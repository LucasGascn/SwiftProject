
import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var movieList:[Movies] = []
    var serieList:[Series] = []
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    @IBOutlet weak var toggleOutlet: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.favoritesTableView.delegate = self
        self.favoritesTableView.dataSource = self
        
        loadData()
        
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
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
            cell.favoriteResumeView.text = self.movieList[indexPath.row].synopsis
            cell.favoriteImageView.image = UIImage.img3
        }else{
            cell.favoriteTitleView.text = self.serieList[indexPath.row].name
            cell.favoriteResumeView.text = self.serieList[indexPath.row].synopsis
            cell.favoriteImageView.image = UIImage.img4
            //cell.textLabel?.text = self.serieList[indexPath.row].name
        }
        // Configure the cell...

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "detailView") as? DetailViewController {
            
            //Afficher une modal
            vc.searchId = self.toggleOutlet.selectedSegmentIndex == 0 ? Int(self.movieList[indexPath.item].id): Int(self.serieList[indexPath.item].id)
            
            vc.searchType = self.toggleOutlet.selectedSegmentIndex == 0 ? "movie" : "tv"
            vc.canBeDeleted = true
            
            vc.favoriteVc = self
            
            self.present(vc, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func toggleTableView(_ sender: Any) {
        self.favoritesTableView.reloadData()
    }
    
    func loadData(){
        self.movieList.removeAll()
        self.serieList.removeAll()
        let username = UserDefaults.standard.string(forKey: "username")
        let password = UserDefaults.standard.string(forKey: "password")
        let dataManager = CoreDataManager()
        var args = ["name": username, "password" : password ]
        var user = dataManager.fetchObjects(Users.self, withArguments: args).first as? Users
        
        if let movies = user?.movies {
            let movieArray = movies.allObjects as? [Movies]
            
            for movie in movieArray ?? []{
                self.movieList.append(movie)
            }
        }
        if let series = user?.series {
            let serieArray = series.allObjects as? [Series]
            
            for serie in serieArray ?? []{
                self.serieList.append(serie)
            }
        }
        self.favoritesTableView.reloadData()
    }
}
