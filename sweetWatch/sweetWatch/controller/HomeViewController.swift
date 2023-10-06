//
//  HomeViewController.swift
//  sweetWatch
//
//  Created by Jules Duarte on 03/10/2023.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    let headers = [
      "accept": "application/json",
      "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxODQyNTJmYjRjNDVkMzE4ZjE1NGQwNzIzOTYzZmRjNiIsInN1YiI6IjY1MWJjYzA5NjcyOGE4MDEzYzQxNzI5ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.xtWVRlxeUp42ahtck_sWoi1EtkR6hL16hBCRRsOztUk"
    ]

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    
    var Movies : [Movie] = []
    var Series : [Serie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right:20)
        layout.minimumInteritemSpacing = 30
        
        self.moviesCollectionView.setCollectionViewLayout(layout, animated: true)
        self.moviesCollectionView.dataSource = self
        self.moviesCollectionView.delegate = self
        
        self.seriesCollectionView.setCollectionViewLayout(layout, animated: true)
        self.seriesCollectionView.dataSource = self
        self.seriesCollectionView.delegate = self
        
        
        self.moviesCollectionView.register(UINib(nibName:"CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:CustomCollectionViewCell.identifier)
        
        self.seriesCollectionView.register(UINib(nibName:"CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:CustomCollectionViewCell.identifier)
        GetMovies()
        GetSeries()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GetMovies()
        GetSeries()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.moviesCollectionView{
            return Movies.count
        }
        if collectionView == self.seriesCollectionView{
            return Series.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.moviesCollectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {
            fatalError("failed")
        }
        
        cell.layer.cornerRadius = 10
        if collectionView == self.moviesCollectionView {
            cell.configure(image: "https://www.themoviedb.org/t/p/w1280/\(Movies[indexPath.item].image)")
        }
        if collectionView == self.seriesCollectionView {
            cell.configure(image: "https://www.themoviedb.org/t/p/w1280/\(Series[indexPath.item].image)")
        }
        return cell
    }
    
    func GetMovies(){
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/trending/movie/day?language=en-US")! as URL,cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error as Any)
          } else {
              if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers){
                  if let data = json as? [String:AnyObject] {
                      if let items = data["results"] as? [[String : AnyObject]]{
                          for item in items {
                              let id = item["id"] as? Int
                              let image = item["poster_path"] as? String
                              let movie = Movie(id: id ?? 0, name: "", image: image ?? "", resume: "", rating: 0, actors: [])
                              self.Movies.append(movie)
                              
                          }
                      }
                  }
              }
              DispatchQueue.main.async {
                  self.moviesCollectionView.reloadData()
              }
          }
        })
        dataTask.resume()
    }
    
    func GetSeries(){
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/trending/tv/day?language=en-US")! as URL,cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error as Any)
          } else {
              if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers){
                  if let data = json as? [String:AnyObject] {
                      if let items = data["results"] as? [[String : AnyObject]]{
                          for item in items {
                              let id = item["id"] as? Int
                              let image = item["poster_path"] as? String
                              let serie = Serie(id: id ?? 0, name: "", image: image ?? "", resume: "", rating: 0, actors: [])
                              self.Series.append(serie)
                              
                          }
                      }
                  }
              }
              DispatchQueue.main.async {
                  self.seriesCollectionView.reloadData()
              }
          }
        })
        dataTask.resume()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "detailView") as? DetailViewController {
            
            //Afficher une modal
            vc.searchId = collectionView == self.seriesCollectionView ? Series[indexPath.item].id : Movies[indexPath.item].id
            vc.searchType = collectionView == self.seriesCollectionView ? "tv" : "movie"

            self.present(vc, animated: true, completion: nil)
            
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
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
