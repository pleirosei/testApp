//
//  TestTableViewController.swift
//  
//
//  Created by Sean Livingston on 8/25/15.
//
//

import UIKit
import Parse

class TestTableViewController: UITableViewController {

    var allNotes: [Note] = []
    
    var passNote: Note!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadNotes()
        
        self.tableView.reloadData()

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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.allNotes.count
    }
    
    func loadNotesFromLocalDataStore() {
        self.allNotes.removeAll(keepCapacity: true)
        let query = Note.query()
        query?.fromLocalDatastore()
        query?.whereKeyExists("title")
        query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            if error != nil {
                println(error)
            } else {
                if let theNotes = objects as? [Note] {
                    for note in theNotes {
                        self.allNotes.append(note)
                        println(self.allNotes)
                    }
                }
                self.tableView.reloadData()
            }
        })
    }
    
    func loadNotes() {
        
//        PFObject.unpinAllObjecrtsInBackgroundWithBlock(nil)
        
        self.allNotes.removeAll(keepCapacity: true)
        let query = Note.query()
        query?.whereKeyExists("title")
        query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            if error != nil {
                println(error)
            } else {
                PFObject.pinAllInBackground(objects, block: nil)
                self.loadNotesFromLocalDataStore()
//                if let theNotes = objects as? [Note] {
//                    for note in theNotes {
//                        self.allNotes.append(note)
//                        println(self.allNotes)
//                    }
//                }
//                self.tableView.reloadData()
            }
        })
    }
    
    

    override func viewDidAppear(animated: Bool) {
        loadNotesFromLocalDataStore()
        loadNotes()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("noteCell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = self.allNotes[indexPath.row].title
        
        passNote = self.allNotes[indexPath.row]
        
        println(self.allNotes)

        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("showNote", sender: self.tableView.cellForRowAtIndexPath(indexPath))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showNote" {
            
            let destVC = segue.destinationViewController as! ViewController
            destVC.newNote = passNote
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
