//
//  MasterViewControllerTableViewController.swift
//  a
//
//  Created by John Smith on 10/25/17.
//  Copyright © 2017 John Smith. All rights reserved.
//

import UIKit

var albums: [AlbumRecord] = []

protocol AlbumSelectionDelegate: class {
    func selectAlbum(albumIndex: Int)
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

        //navigationController?.
        
        
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

    //override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
       // let selectedAlbum = albums[indexPath.row]
       // self.delegate?.selectAlbum(album: selectedAlbum, index: indexPath.row)
   // }
    
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
