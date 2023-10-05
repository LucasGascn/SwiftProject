//
//  DetailViewController.swift
//  sweetWatch
//
//  Created by coding on 04/10/2023.
//

import UIKit
import Foundation


class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var detailScrollView: UIScrollView!
    
    @IBOutlet weak var noteLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    
    @IBOutlet weak var descriptionContentLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var genreTitleLabel: UILabel!
    
    @IBOutlet weak var genreContentLabel: UILabel!
    
    
    struct ItemToDisplay{
        var id: Int
        var title: String
        var image: UIImage
        var description : String
        var genre : [String]
        var date : String
        var note : Double
    }
    
    var itemToDisplay =  ItemToDisplay(id: 0, title: "", image: UIImage(), description: "", genre: [], date: "", note: 0)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        
        // Do any additional setup after loading the view.
        
        
        

        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxODQyNTJmYjRjNDVkMzE4ZjE1NGQwNzIzOTYzZmRjNiIsInN1YiI6IjY1MWJjYzA5NjcyOGE4MDEzYzQxNzI5ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.xtWVRlxeUp42ahtck_sWoi1EtkR6hL16hBCRRsOztUk"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/movie/624860?language=en-US")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error as Any)
          } else {
              if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                  if let data = json as? [String: AnyObject] {
                      
                       
                      self.itemToDisplay.title = data["original_title"] as! String
                      self.itemToDisplay.id = data["id"] as! Int
                      self.itemToDisplay.description = data["overview"] as! String
                      self.itemToDisplay.date = data["release_date"] as! String
                      self.itemToDisplay.note = data["vote_average"] as! Double
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
        
        
        /*
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let url = URL(string: "https://api.deezer.com/search?q=a")!
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                    if let data = json as? [String: AnyObject] {
                        
                        if let items = data["data"] as? [[String: AnyObject]] {
                            for item in items {
                                //print(item["link"]!)
                                //self.browsers.append(item["link"]! as! String)
                                if let artist = Artist(json: item) {
                                   self.navigateur.append(artist)
                                }
                                
                            }
                        }
                    }
                }
            }
*/
    }
    
    
    
    @IBAction func addToWatchlistAction(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
