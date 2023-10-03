
import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchTableView.delegate = self
        self.searchTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    

}
