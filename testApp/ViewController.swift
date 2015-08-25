//
//  ViewController.swift
//  testApp
//
//  Created by Sean Livingston on 8/25/15.
//  Copyright (c) 2015 Sean Livingston. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var newNote: Note!
    
    @IBOutlet weak var noteTitle: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNote()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    
    @IBAction func saveNote(sender: AnyObject) {
        if newNote == nil {
            newNote = Note()
        }
        
        newNote.title = noteTitle.text
        newNote.saveEventually(nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func loadNote() {
        if let theNote = newNote {
            self.noteTitle.text = theNote.title
        }
    }


}

