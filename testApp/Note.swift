//
//  Note.swift
//  testApp
//
//  Created by Sean Livingston on 8/25/15.
//  Copyright (c) 2015 Sean Livingston. All rights reserved.
//

import Foundation
import Parse

class Note: PFObject, PFSubclassing {
    
    static func parseClassName() -> String {
        return "Note"
    }
    
    override init() {
        super.init()
    }
    
    @NSManaged var title: String
}
