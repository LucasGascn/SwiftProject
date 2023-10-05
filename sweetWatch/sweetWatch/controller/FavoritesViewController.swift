
import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var movieList:[Movie] = []
    var serieList:[Serie] = []
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    @IBOutlet weak var toggleOutlet: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //JEU DE DONNEE TEST
        let movie1 = Movie(
            id: 1,
            name: "film1",
            image: "image film1",
            resume: "resume1",
            rating: 4.2,
            actors: [Actor(name: "john wick", image: "image john")]
        )
        let movie2 = Movie(
            id: 1,
            name: "film2",
            image: "image film2",
            resume: "resume2",
            rating: 2.2,
            actors: [Actor(name: "john wick2", image: "image john2")]
        )
        let serie1 = Serie(
            id: 1,
            name: "serie1",
            image: "image serie1",
            resume: "resumeserie1",
            rating: 4.2,
            actors: [Actor(name: "john wick", image: "image john")]
        )
        let serie2 = Serie(
            id: 1,
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
        //select movie or serie to show
        if self.toggleOutlet.selectedSegmentIndex == 0{
            return self.movieList.count
        }else{
            return self.serieList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "favoriteCellIdentifier", for: indexPath) as! CustomFavoriteCell
        
        //make cell rounded
        cell.favoriteView.layer.cornerRadius = 15
        cell.favoriteImageView.layer.cornerRadius = 5
        
        if self.toggleOutlet.selectedSegmentIndex == 0{
            cell.favoriteTitleView.text = self.movieList[indexPath.row].name
            cell.favoriteResumeView.text = self.movieList[indexPath.row].resume
            cell.favoriteImageView.image = UIImage.img3
        }else{
            cell.favoriteTitleView.text = self.serieList[indexPath.row].name
            cell.favoriteResumeView.text = self.serieList[indexPath.row].resume
            cell.favoriteImageView.image = UIImage.img4
            //cell.textLabel?.text = self.serieList[indexPath.row].name
        }
        // Configure the cell...

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "detailView") as? DetailViewController {
            
            //Afficher une modal
            vc.searchId = 114461
            vc.searchType = self.toggleOutlet.selectedSegmentIndex == 0 ? "movie" : "tv"
            //self.navigateur[indexPath.row].urlPage
            //vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
            //Afficher push navigation
            //self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func toggleTableView(_ sender: Any) {
        self.favoritesTableView.reloadData()
    }
        
}
