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
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        albums.append(AlbumRecord(performer: performerInput.text!, title: titleInput.text!, genre: genreInput.text!, publicationYear: publicationYearInput.text!, tracksNumber: tracksNumberInput.text!))
        
            showRecord(newRecord: false, recordNumber: lastViewRecord != nil ? lastViewRecord! : 0)
    }
    
    var albums: [AlbumRecord] = []
    var lastViewRecord: Int? = nil
    
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    var albumsLoadDataTask: URLSessionDataTask?
    
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
            
            mainLabel.text = "Rekord " + String(recordNumber!) + " z " + String(albums.count);
            newRecordButton.isEnabled = true
            saveButton.isEnabled = false
            deleteButton.isEnabled = true
            nextButton.isEnabled = false
            previousButton.isEnabled = false

        }
    }
    
    func loadAlbums() {
        let url = URL(string: "https://isebi.net/albums.php")
        let urlRequest = URLRequest(url: url!)
        
        print("load albums")
        albumsLoadDataTask = defaultSession.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let data = data {
                do {
                let res = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue:0)) as! [AnyObject]
                
                for item in res{
                    var newAlbum = AlbumRecord()
                    newAlbum.title = item["title"] as? String
                    self.albums.append(newAlbum)
                }
                
                DispatchQueue.main.async {
                    self.showRecord(newRecord: false, recordNumber: 0)
                }
                } catch let error as NSError{
                    print("The error in the catch block is \(error)")
                }
                catch
                {
                    print("Catch Block")
                }
            }
        
            })
        
        albumsLoadDataTask?.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadAlbums()
        mainLabel.text = "Nowy rekord"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

