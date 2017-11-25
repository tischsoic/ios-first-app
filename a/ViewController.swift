import UIKit

class AlbumTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var performer: UILabel!
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
        let album = AlbumRecord(performer: performerInput.text!, title: titleInput.text!, genre: genreInput.text!, publicationYear: publicationYearInput.text!, tracksNumber: tracksNumberInput.text!)
        var goToRecord = 0
        
        if (currentRecordIndex! == -1) {
            albums.append(album)
            goToRecord = lastViewedRecord != nil ? lastViewedRecord! : 0
        } else if let index = currentRecordIndex {
            albums[index] = album
            goToRecord = index
        }
        
        showRecord(recordIndex: goToRecord)
    }
    
    @IBAction func previousButtonClicked(_ sender: Any) {
        if (currentRecordIndex == nil) {
            return
        }
        if (currentRecordIndex! > 0) {
            showRecord(recordIndex: currentRecordIndex! - 1)
        } else if (currentRecordIndex! == -1) {
            showRecord(recordIndex: lastViewedRecord != nil ? lastViewedRecord! : 0)
        }
    }
    
    @IBAction func nexButtonClicked(_ sender: Any) {
        if (currentRecordIndex == nil) {
            return
        }
        if (currentRecordIndex! < albums.count - 1) {
            showRecord(recordIndex: currentRecordIndex! + 1)
        } else if (currentRecordIndex! == albums.count - 1) {
            showRecord(recordIndex: -1)
        }
    }
    
    @IBAction func newRecordButtonClicked(_ sender: Any) {
        if (currentRecordIndex != nil && currentRecordIndex! == -1) {
            return
        }
        
        showRecord(recordIndex: -1)
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        if (currentRecordIndex == nil) {
            return
        }
        
        if (currentRecordIndex! == -1) {
            showRecord(recordIndex: lastViewedRecord != nil ? lastViewedRecord! : 0)
        } else {
            albums.remove(at: currentRecordIndex!)
            showRecord(recordIndex: lastViewedRecord != nil ? lastViewedRecord! : 0)        }
    }
    
    @IBAction func performerEditingDidBegin(_ sender: Any) {
        saveButton.isEnabled = true
    }
    
    @IBAction func titleEditingDidBegin(_ sender: Any) {
        saveButton.isEnabled = true
    }
    
    @IBAction func genreEditingDidBegin(_ sender: Any) {
        saveButton.isEnabled = true
    }
    
    @IBAction func yearEditingDidBegin(_ sender: Any) {
        saveButton.isEnabled = true
    }
    
    @IBAction func tracksNumberEditingDidBegin(_ sender: Any) {
        saveButton.isEnabled = true
    }
    
    
    
    var currentRecordIndex: Int? = nil
    var lastViewedRecord: Int? = nil
    
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    var albumsLoadDataTask: URLSessionDataTask?
    
    func showRecord(recordIndex: Int) {
        if (currentRecordIndex != nil && currentRecordIndex! != -1) {
            lastViewedRecord = currentRecordIndex!
        }
        let recordExists = recordIndex < albums.count && recordIndex >= 0
        currentRecordIndex = recordIndex
        
        if !recordExists {
            currentRecordIndex = -1
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
            previousButton.isEnabled = albums.count != 0
        } else {
            let album = albums[recordIndex]
            
            performerInput.text = album.performer
            titleInput.text = album.title
            genreInput.text = album.genre
            publicationYearInput.text = album.publicationYear
            tracksNumberInput.text = album.tracksNumber
            
            mainLabel.text = "Rekord " + String(recordIndex + 1) + " z " + String(albums.count);
            newRecordButton.isEnabled = true
            saveButton.isEnabled = false
            deleteButton.isEnabled = true
            nextButton.isEnabled = true
            previousButton.isEnabled = recordIndex != 0
        }
        
        performerInput.resignFirstResponder()
        titleInput.resignFirstResponder()
        genreInput.resignFirstResponder()
        publicationYearInput.resignFirstResponder()
        tracksNumberInput.resignFirstResponder()
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
                    print(data)
                let res = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue:0)) as! [AnyObject]
                
                for item in res{
                    if (item is NSNull) {
                        continue
                    }
                    var newAlbum = AlbumRecord()
                    newAlbum.title = item["album"] as! String
                    newAlbum.genre = item["genre"] as! String
                    newAlbum.performer = item["artist"] as! String
                    newAlbum.publicationYear = String(item["year"] as! Int)
                    newAlbum.tracksNumber = String(item["tracks"] as! Int)
                    albums.append(newAlbum)
                }
                
                DispatchQueue.main.async {
                    self.showRecord(recordIndex: 0)
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
        showRecord(recordIndex: -1)
        loadAlbums()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

