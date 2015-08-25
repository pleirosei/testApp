//
//  SaveNoteViewController.swift
//  
//
//  Created by Sean Livingston on 8/25/15.
//
//

import UIKit
import Parse

class SaveNoteViewController: UIViewController {

    var theNote: Note = Note()
    
    @IBOutlet weak var newNote: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveNote(sender: AnyObject) {
        self.theNote.title = newNote.text
        self.theNote.saveEventually(nil)
        
        self.theNote.pinInBackgroundWithBlock(nil)
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
