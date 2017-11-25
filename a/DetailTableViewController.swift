//
//  DetailTableViewController.swift
//  a
//
//  Created by John Smith on 11/25/17.
//  Copyright © 2017 John Smith. All rights reserved.
//

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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailTableViewController: AlbumSelectionDelegate {
    func selectAlbum(albumIndex: Int) {
        self.albumIndex = albumIndex
    }
}
