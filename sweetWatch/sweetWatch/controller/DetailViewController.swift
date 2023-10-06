//
//  DetailViewController.swift
//  sweetWatch
//
//  Created by coding on 04/10/2023.
//

import UIKit
import Foundation


class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var detailScrollView: UIScrollView!
    
    @IBOutlet weak var noteLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    
    @IBOutlet weak var descriptionContentLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var genreTitleLabel: UILabel!
    
    @IBOutlet weak var genreContentLabel: UILabel!
    
    @IBOutlet weak var detailButton: UIButton!
    
    @IBOutlet weak var actorsCollectionView: UICollectionView!
    
    
    //navigation variable
    var searchType: String = ""
    var searchId: Int = 0
    var canBeDeleted = false
    
    //JULES création du tableau actors VIDE
    var actors:[Actor] = []
    
    struct ItemToDisplay{
        var id: Int
        var title: String
        var image: UIImage
        var imageUrl : String
        var description : String
        var genre : [String]
        var date : String
        var note : Double
    }
    var itemToDisplay =  ItemToDisplay(id: 0, title: "", image: UIImage(), imageUrl: "", description: "", genre: [], date: "", note: 0)
    
    var favoriteVc : FavoritesViewController = FavoritesViewController()

    
    let headers = [
      "accept": "application/json",
      "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxODQyNTJmYjRjNDVkMzE4ZjE1NGQwNzIzOTYzZmRjNiIsInN1YiI6IjY1MWJjYzA5NjcyOGE4MDEzYzQxNzI5ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.xtWVRlxeUp42ahtck_sWoi1EtkR6hL16hBCRRsOztUk"
    ]
    
    var searchVc : SearchViewController = SearchViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //JULES : COPIE DE CE QUE TU AVAIS FAIT EN ADAPTANT
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right:20)
        layout.minimumInteritemSpacing = 30
        
        self.actorsCollectionView.setCollectionViewLayout(layout, animated: true)
        self.actorsCollectionView.dataSource = self
        self.actorsCollectionView.delegate = self
        
        self.actorsCollectionView.register(UINib(nibName:"ActorsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:ActorsCollectionViewCell.identifier)
        // Do any additional setup after loading the view.
        
        if canBeDeleted {
            self.detailButton.setTitle("Remove from WatchList", for: .normal)
            self.detailButton.backgroundColor = .clear
            self.detailButton.backgroundColor = UIColor.red
        }
        getDetail()
        getActors()
    }
    
    func getActors(){
        //JULES ICI LA REQUETE POUR RECUP LES ACTEURS DU FILM
        //AVEC CREATTION DU TABLEAU actors
        var request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/\(searchType)/\(self.searchId)/credits?language=en-US")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared

        var dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                    if let data = json as? [String:AnyObject] {
                        if let items = data["cast"] as? [[String : AnyObject]]{
                            for item in items {
                                let id = item["id"] as? Int
                                let name = item["name"] as? String
                                let image = item["profile_path"] as? String
                                let actor = Actor(id: id ?? 0, name: name ?? "", image: image ?? "")
                                self.actors.append(actor)
                                
                            }
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.actorsCollectionView.reloadData()
                }
            }
        })
        dataTask.resume()
    }
    
    func getDetail(){
        var request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/\(searchType)/\(self.searchId)?language=en-US")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        var dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error as Any)
          } else {
              if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                  if let data = json as? [String: AnyObject] {
                      
                       
                      self.itemToDisplay.title = self.searchType == "movie" ? data["original_title"] as! String : data["original_name"] as! String
                      self.itemToDisplay.id = data["id"] as! Int
                      self.itemToDisplay.description = data["overview"] as! String
                      self.itemToDisplay.date = self.searchType == "movie" ? data["release_date"] as! String : data["first_air_date"] as! String
                      self.itemToDisplay.note = data["vote_average"] as! Double
                      self.itemToDisplay.imageUrl = data["poster_path"] as! String
                      let imageUrlString = "https://image.tmdb.org/t/p/w500" + (data["poster_path"] as! String)
                      if let imageUrl = URL(string: imageUrlString){
                          let imageData = try? Data(contentsOf: imageUrl)
                          if let imageData = imageData{
                              let image = UIImage(data: imageData)
                              self.itemToDisplay.image = image as! UIImage
                          }
                      }
                      if let genres = data["genres"] as? [[String: AnyObject]]{
                          for genre in genres{
                              self.itemToDisplay.genre.append(genre["name"] as! String)
                          }
                      }
                                
                    //LOAD DATA IN VIEW
                      DispatchQueue.main.async {
                          self.titleLabel.text = self.itemToDisplay.title
                          self.noteLabel.text = "Note : \(self.itemToDisplay.note)"
                          self.dateLabel.text = "Date de sortie : \(self.itemToDisplay.date)"
                          self.descriptionContentLabel.text = self.itemToDisplay.description
                          self.imageView.image = self.itemToDisplay.image
                          for genre in self.itemToDisplay.genre{
                              self.genreContentLabel.text = (self.genreContentLabel.text!) + genre + "\n"
                          }
                      }
                  }
              }
          }
        })
        dataTask.resume()

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actors.count
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.actorsCollectionView.dequeueReusableCell(withReuseIdentifier: ActorsCollectionViewCell.identifier, for: indexPath) as? ActorsCollectionViewCell else {
            fatalError("failed")
        }
        
        cell.layer.cornerRadius = 20
        
        print()
        cell.configure(image: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2\(actors[indexPath.item].image)")
        cell.actorsNameLabel.text = actors[indexPath.item].name
        return cell
    }
    
    
    
    
    

    
    @IBAction func addToWatchlistAction(_ sender: Any) {
        let username = UserDefaults.standard.string(forKey: "username")
        let password = UserDefaults.standard.string(forKey: "password")
        let dataManager = CoreDataManager()
        var args = ["name": username, "password" : password ]
        var user = dataManager.fetchObjects(Users.self, withArguments: args).first as? Users
        if canBeDeleted{
            if self.searchType == "tv"{
                if let series = user?.series {
                    let serieArray = series.allObjects as? [Series]
                    
                    for serie in serieArray ?? []{
                        if serie.name == self.itemToDisplay.title {
                            user?.removeFromSeries(serie)
                            dataManager.delete(item: serie)
                        }
                    }
                }
            }
            else{
                if let movies = user?.movies {
                    let movieArray = movies.allObjects as? [Movies]
                    
                    for movie in movieArray ?? []{
                        if movie.name == self.itemToDisplay.title{
                            user?.removeFromMovies(movie)
                            dataManager.delete(item: movie)
                        }
                    }
                }

            }
            self.dismiss(animated: true){
                self.favoriteVc.loadData()
            }
        }else{
            if self.searchType == "tv"{
                var serie = dataManager.getEntity(entityName: "Series") as? Series
                serie?.id = Int64(self.itemToDisplay.id)
                serie?.image = self.itemToDisplay.imageUrl
                serie?.name = self.itemToDisplay.title
                serie?.synopsis = self.itemToDisplay.description
                
                user?.addToSeries(serie ?? Series())
            }
            else{
                var movie = dataManager.getEntity(entityName: "Movies") as? Movies
                movie?.id = Int64(self.itemToDisplay.id)
                movie?.image = self.itemToDisplay.imageUrl
                movie?.name = self.itemToDisplay.title
                movie?.synopsis = self.itemToDisplay.description
                
                user?.addToMovies(movie ?? Movies())
            }
            
            self.dismiss(animated: true){
            }
            dataManager.save()
        }
        

    }
    

}


// JULES ICI AUSSI COPI
extension DetailViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 180.0, height: 260.0)


        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 1.0
        }

        func collectionView(_ collectionView: UICollectionView, layout
            collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 30.0
        }
    }
