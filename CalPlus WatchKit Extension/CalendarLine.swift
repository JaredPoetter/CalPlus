//
//  CalendarLine.swift
//  CalPlus WatchKit Extension
//
//  Created by Jared Poetter on 11/18/17.
//  Copyright © 2017 Jared Poetter. All rights reserved.
//

import WatchKit

class CalendarLine: NSObject {

    var lineType:String 
    var contents:String

    init(lineType: String, contents: String) {
        self.lineType = lineType
        self.contents = contents
    }
    
}
