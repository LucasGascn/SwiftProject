
import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var movieList:[Movie] = []
    var serieList:[Serie] = []
    var listToShow:[Any] = []
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    
    @IBOutlet weak var toggleOutlet: UISegmentedControl!
    
    
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
        let serie1 = Serie(
            name: "serie1",
            image: "image serie1",
            resume: "resumeserie1",
            rating: 4.2,
            actors: [Actor(name: "john wick", image: "image john")]
        )
        let serie2 = Serie(
            name: "serie2",
            image: "image serie2",
            resume: "resumeserie2",
            rating: 2.2,
            actors: [Actor(name: "john wick2", image: "image john2")]
        )
        self.serieList = [serie1,serie2]
        self.movieList = [movie1,movie2]
        
        
        self.favoritesTableView.delegate = self
        self.favoritesTableView.dataSource = self
        
        // Do any additional setup after loading the view.
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.toggleOutlet.selectedSegmentIndex == 0{
            return self.movieList.count
        }else{
            return self.serieList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCellIdentifier", for: indexPath)

        if self.toggleOutlet.selectedSegmentIndex == 0{
            cell.textLabel?.text = self.movieList[indexPath.row].name
        }else{
            cell.textLabel?.text = self.serieList[indexPath.row].name
        }
        
        
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.gray
        }
        // Configure the cell...

        return cell
    }
    
    
    
    @IBAction func toggleTableView(_ sender: Any) {
        self.favoritesTableView.reloadData()
    }
        
}
