import UIKit

struct AlbumRecord {
    var performer = ""
    var title = ""
    var genre = ""
    var publicationYear = ""
    var tracksNumber = ""
}

class ViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var performerInput: UITextField!
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var genreInput: UITextField!
    @IBOutlet weak var publicationYearInput: UITextField!
    @IBOutlet weak var tracksNumberInput: UITextField!
    
    @IBOutlet weak var newRecordButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    
    var albums: [AlbumRecord] = []
    var lastViewRecord: Int? = nil
    
    func showRecord(newRecord: Bool, recordNumber: Int?) {
        if newRecord {
            performerInput.text = ""
            titleInput.text = ""
            genreInput.text = ""
            publicationYearInput.text = ""
            tracksNumberInput.text = ""
            
            mainLabel.text = "Nowy rekord"
            newRecordButton.isEnabled = false
            saveButton.isEnabled = true
            deleteButton.isEnabled = true
            nextButton.isEnabled = false
            previousButton.isEnabled = false
        } else {
            let album = albums[recordNumber!]
            
            performerInput.text = album.performer
            titleInput.text = album.title
            genreInput.text = album.genre
            publicationYearInput.text = album.publicationYear
            tracksNumberInput.text = album.tracksNumber
            
            mainLabel.text = "Nowy rekord"
            newRecordButton.isEnabled = true
            saveButton.isEnabled = false
            deleteButton.isEnabled = true
            nextButton.isEnabled = false
            previousButton.isEnabled = false

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mainLabel.text = "Nowy rekord"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

