
import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    
    var movieList:[Movie] = []
    
    @IBOutlet weak var seriesTableView: UITableView!
    
    @IBOutlet weak var movieTableView
    : UITableView!
    
    @IBOutlet weak var seriesButton: UIButton!
    @IBOutlet weak var moviesButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //JEU DE DONNEE TEST
        let movie1 = Movie(
            name: "film1",
            image: "image film1",
            resume: "resume1",
            rating: 4.2,
            actors: [Actor(name: "john wick", image: "image john")]
        )
        let movie2 = Movie(
            name: "film2",
            image: "image film2",
            resume: "resume2",
            rating: 2.2,
            actors: [Actor(name: "john wick2", image: "image john2")]
        )
        self.movieList = [movie1,movie2]

        
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
        
        self.seriesTableView.delegate = self
        self.seriesTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        
              
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    @IBAction func Series(_ sender: Any) {
        self.seriesTableView.isHidden = false
        self.movieTableView.isHidden = true
        
        self.moviesButton.backgroundColor = .clear
        self.seriesButton.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.2)
        self.seriesButton.layer.cornerRadius = 10
    }
    
    @IBAction func Movies(_ sender: Any) {
        self.movieTableView.isHidden = false
        self.seriesTableView.isHidden = true
        
        self.seriesButton.backgroundColor = .clear
        self.moviesButton.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.2)
        self.moviesButton.layer.cornerRadius = 10
    }

}
