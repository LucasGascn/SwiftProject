
import UIKit
import Foundation


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate  {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var toggleButton: UISegmentedControl!
    @IBOutlet weak var searchTableView: UITableView!
    
    struct Movie {
        let title: String
        let posterPath: String
        let id: Int
        let resume : String
    }
    var movies: [Movie] = []
    var selectedCategory: String = "movie" // Par défaut, recherche de films

    func popularMovie(){
        self.searchTableView.delegate = self
        self.searchTableView.dataSource = self
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxODQyNTJmYjRjNDVkMzE4ZjE1NGQwNzIzOTYzZmRjNiIsInN1YiI6IjY1MWJjYzA5NjcyOGE4MDEzYzQxNzI5ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.xtWVRlxeUp42ahtck_sWoi1EtkR6hL16hBCRRsOztUk"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/\(selectedCategory)/popular?language=en-US&page=1")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print("Erreur : \(error)")
            } else if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let results = json["results"] as? [[String: Any]] {
                        var moviesArray: [Movie] = []
                        for result in results {
                            if let title = result["title"] as? String,
                               let posterPath = result["poster_path"] as? String,
                               let id = result["id"] as? Int,
                               let resume = result["overview"] as? String
                            {
                                
                                let movie = Movie(title: title, posterPath: posterPath, id: id, resume: resume )
                                moviesArray.append(movie)
                            }
                            
                           else if let title = result["name"] as? String,
                               let posterPath = result["poster_path"] as? String,
                               let id = result["id"] as? Int,
                                let resume = result["overview"] as? String
                            {
                                
                                let movie = Movie(title: title, posterPath: posterPath, id: id, resume: resume)
                                moviesArray.append(movie)
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self.movies = moviesArray
                            self.searchTableView.reloadData()
                        }
                    }
                } catch {
                    print("Erreur lors de l'analyse JSON : \(error)")
                }
            }
        })
        dataTask.resume()
    }
    
    func tcheckSearchBar(){
        if let searchText = searchBar.text, !searchText.isEmpty {
                    searchBar(searchBar, textDidChange: searchText)
                } else {
                    popularMovie()
                }
    }
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            selectedCategory = "movie"
            movies.removeAll()
            tcheckSearchBar()
        } else if sender.selectedSegmentIndex == 1 {
            selectedCategory = "tv" // Pour les séries
            movies.removeAll()
            tcheckSearchBar()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleButton.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        popularMovie()
        [self.searchBar.backgroundColor = UIColor.darkGray];
        [self.searchBar.barTintColor = UIColor.darkGray];
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCellIdentifier", for: indexPath) as! CustomFavoriteCell
        let movie = movies[indexPath.row]
        cell.favoriteView.layer.cornerRadius = 15
        cell.favoriteImageView.layer.cornerRadius = 5
        cell.favoriteTitleView?.text = movie.title
        cell.favoriteImageView?.downloaded(from: URL(string: "https://image.tmdb.org/t/p/w500" + movie.posterPath)!)
        cell.favoriteResumeView?.text = movie.resume == "" ? "No Description" : movie.resume
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "detailView") as? DetailViewController {
            
            //Afficher une modal
            vc.searchId = self.movies[indexPath.item].id
            
            vc.searchType = selectedCategory
            vc.searchVc = self
            
            self.present(vc, animated: true, completion: nil)
            
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        movies.removeAll()
        
        if (searchText.isEmpty){
            popularMovie()
        }else{
            let headers = [
                "accept": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxODQyNTJmYjRjNDVkMzE4ZjE1NGQwNzIzOTYzZmRjNiIsInN1YiI6IjY1MWJjYzA5NjcyOGE4MDEzYzQxNzI5ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.xtWVRlxeUp42ahtck_sWoi1EtkR6hL16hBCRRsOztUk"
            ]
            
            let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/search/\(selectedCategory)?query=\(searchText)&include_adult=false&language=en-US&page=1")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print(error as Any)
                } else if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let results = json["results"] as? [[String: Any]] {
                            
                            var moviesArray: [Movie] = []
                            for result in results {
                                if let title = result["title"] as? String,
                                   let posterPath = result["poster_path"] as? String,
                                   let id = result["id"] as? Int,
                                    let resume = result["overview"] as? String
                                {
                                    
                                    let movie = Movie(title: title, posterPath: posterPath, id: id, resume: resume )
                                    moviesArray.append(movie)
                                }
                                else if let title = result["name"] as? String,
                                    let posterPath = result["poster_path"] as? String,
                                    let id = result["id"] as? Int,
                                        let resume = result["overview"] as? String

                                 {
                                     
                                     let movie = Movie(title: title, posterPath: posterPath, id: id, resume: resume)
                                     moviesArray.append(movie)
                                     
                                 }
                                
                            }
                            DispatchQueue.main.async {
                                self.movies = moviesArray
                                self.searchTableView.reloadData()
                            }
                        }
                    } catch {
                        print("Erreur lors de l'analyse JSON : \(error)")
                    }
                }
            })
            dataTask.resume()
        }
    }
}
