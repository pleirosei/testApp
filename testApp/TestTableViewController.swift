//
//  TestTableViewController.swift
//  
//
//  Created by Sean Livingston on 8/25/15.
//
//

import UIKit

class TestTableViewController: PFQueryTableViewController {

    var allNotes: [Note] = []
    
    var passNote: Note!
    var theIndex: AnyObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func queryForTable() -> PFQuery {
        let query = Note.query()!
        if !IJReachability.isConnectedToNetwork() {
            query.fromLocalDatastore()
        }
        return query
    }
    
    override func objectsDidLoad(error: NSError?) {
        if IJReachability.isConnectedToNetwork() {
            if let theObjects = objects as? [Note] {
                PFObject.pinAllInBackground(theObjects)
            }
        }
        super.objectsDidLoad(error)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        let cell = tableView.dequeueReusableCellWithIdentifier("noteCell") as! PFTableViewCell
        let note = object as! Note
        cell.textLabel?.text = note.title
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let note = self.objectAtIndexPath(indexPath) as! Note
            if IJReachability.isConnectedToNetwork() {
                note.deleteInBackgroundWithBlock({ (success, error) -> Void in
                    self.loadObjects()
                })
            } else {
                note.deleteEventually()
                self.loadObjects()
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showNote" {
            
            let destVC = segue.destinationViewController as! ViewController
            let cell = sender as! UITableViewCell
            destVC.newNote = passNote
        }
    }
    
    @IBAction func addNote(sender: AnyObject) {
        let note = Note()
        note.title = NSUUID().UUIDString
        
        if IJReachability.isConnectedToNetwork() {
            note.saveInBackgroundWithBlock({ (success, error) -> Void in
                self.loadObjects()
            })
        } else {
            note.saveEventually()
            println("calling saveEventually")
            self.loadObjects()
        }
    }
    
    @IBAction func editTable(sender: AnyObject) {
        tableView.editing = !tableView.editing
    }
}
