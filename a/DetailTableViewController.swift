import UIKit

class DetailTableViewController: UITableViewController {

    @IBOutlet weak var performerInput: UITextField!
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var genreInput: UITextField!
    @IBOutlet weak var publicationYearInput: UITextField!
    @IBOutlet weak var tracksNumberInput: UITextField!
    
    var masterViewController: MasterViewControllerTableViewController?
    
    var albumIndex: Int? {
        didSet (newIndex) {
            self.setInputs();
        }
    }
    
    @IBAction func deleteAlbum(_ sender: Any) {
        if (albumIndex == nil || albumIndex! == -1) {
            return
        }
        albums.remove(at: albumIndex!)
        reloadMasterList()
        
        if (albums.count > 0) {
            albumIndex = 0
            return
        }
        
        albumIndex = -1
    }
    
    @IBAction func performerInputValueChanged(_ sender: Any) {
        if let index = albumIndex, index != -1 {
            albums[index].performer = performerInput.text!
            reloadMasterList()
        }
    }
    @IBAction func titleInputValueChanged(_ sender: Any) {
        if let index = albumIndex, index != -1 {
            albums[index].title = titleInput.text!
            reloadMasterList()
        }
    }
    @IBAction func genreInputValueChanged(_ sender: Any) {
        if let index = albumIndex, index != -1 {
            albums[index].genre = genreInput.text!
            reloadMasterList()
        }
    }
    @IBAction func publicationYearInputValueChanged(_ sender: Any) {
        if let index = albumIndex, index != -1{
            albums[index].publicationYear = publicationYearInput.text!
            reloadMasterList()
        }
    }
    @IBAction func tracksNumberInputValueChanged(_ sender: Any) {
        if let index = albumIndex, index != -1 {
            albums[index].tracksNumber = tracksNumberInput.text!
            reloadMasterList()
        }
    }
   
    var detailItemIndex: Int?
    
    func setInputs(album: AlbumRecord) {
        performerInput.text = album.performer;
        titleInput.text = album.title;
        genreInput.text = album.genre;
        publicationYearInput.text = album.publicationYear;
        tracksNumberInput.text = album.tracksNumber;
    }
    
    func reloadMasterList() {
        if let master = masterViewController {
            master.tableView.reloadData()
        }
    }
    
    func setTitle() {
        if let index = albumIndex {
            if (index != -1) {
                self.title = "Edycja rekordu " + String(index) + " z " + String(albums.count)
                return
            }
        }
        self.title = "Edycja pustego rekordu"
    }
    
    func setInputs() {
        setTitle()
        
        if (!isViewLoaded) {
            return
        }
        if let index = albumIndex {
            if (index != -1) {
                let album = albums[index]
                self.setInputs(album: album)
                return
            }
        }
        let emptyAlbum = AlbumRecord(performer: "", title: "", genre: "", publicationYear: "", tracksNumber: "")
        self.setInputs(album: emptyAlbum)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInputs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

}

extension DetailTableViewController: AlbumSelectionDelegate {
    func selectAlbum(albumIndex: Int) {
        self.albumIndex = albumIndex
    }
}
