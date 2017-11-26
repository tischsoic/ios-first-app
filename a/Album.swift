import Foundation

class AlbumRecord: NSObject, NSCoding {
    var performer = ""
    var title = ""
    var genre = ""
    var publicationYear = ""
    var tracksNumber = ""
    
    override init() {}
    
    init(performer: String, title: String, genre: String, publicationYear: String, tracksNumber: String) {
        self.performer = performer
        self.title = title
        self.genre = genre
        self.publicationYear = publicationYear
        self.tracksNumber = tracksNumber
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let obj = aDecoder.decodeObject(forKey: "performer") as? String {
            self.performer = obj
        }
        if let obj = aDecoder.decodeObject(forKey: "title") as? String {
            self.title = obj
        }
        if let obj = aDecoder.decodeObject(forKey: "genre") as? String {
            self.genre = obj
        }
        if let obj = aDecoder.decodeObject(forKey: "publicationYear") as? String {
            self.publicationYear = obj
        }
        if let obj = aDecoder.decodeObject(forKey: "tracksNumber") as? String {
            self.tracksNumber = obj
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(performer, forKey: "performer")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(genre, forKey: "genre")
        aCoder.encode(publicationYear, forKey: "publicationYear")
        aCoder.encode(tracksNumber, forKey: "tracksNumber")
    }
    
}
