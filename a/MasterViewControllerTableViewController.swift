import UIKit

var albums: [AlbumRecord] = []

protocol AlbumSelectionDelegate: class {
    func selectAlbum(albumIndex: Int)
}

class AlbumTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var performer: UILabel!
}
class MasterViewControllerTableViewController: UITableViewController {

    weak var delegate: AlbumSelectionDelegate?
    
    @IBAction func addAlbum(_ sender: Any) {
        var newAlbum = AlbumRecord()
        newAlbum.title = ""
        newAlbum.genre = ""
        newAlbum.performer = ""
        newAlbum.publicationYear = ""
        newAlbum.tracksNumber = ""
        albums.append(newAlbum)
        
        self.tableView.reloadData()
        
        self.delegate?.selectAlbum(albumIndex: albums.count - 1)
        
        if let detailViewController = self.delegate as? DetailTableViewController {
            splitViewController?.showDetailViewController(detailViewController, sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> AlbumTableViewCell {
        let albumCell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! AlbumTableViewCell
        
        albumCell.title?.text = albums[indexPath.row].title
        albumCell.year?.text = albums[indexPath.row].publicationYear
        albumCell.performer?.text = albums[indexPath.row].performer

        return albumCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectAlbum(albumIndex: indexPath.row)
        
        if let detailViewController = self.delegate as? DetailTableViewController {
            splitViewController?.showDetailViewController(detailViewController, sender: nil)
        }
    }

}
