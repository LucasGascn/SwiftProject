
import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    @IBOutlet weak var toggleOutlet: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.favoritesTableView.delegate = self
        self.favoritesTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    @IBAction func toggleTableView(_ sender: Any) {
    }

}
