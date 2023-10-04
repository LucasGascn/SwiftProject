
import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var seriesTableView: UITableView!
    
    @IBOutlet weak var movieTableView
    : UITableView!
    
    @IBOutlet weak var seriesButton: UIButton!
    @IBOutlet weak var moviesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
    
    @IBAction func Movies(_ sender: Any) {
        self.movieTableView.isHidden = false
        self.seriesTableView.isHidden = true
    }

}
