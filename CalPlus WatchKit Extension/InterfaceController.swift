//
//  InterfaceController.swift
//  Calendar WatchKit Extension
//
//  Created by Jared Poetter on 10/11/17.
//  Copyright © 2017 Jared Poetter. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var monthLabel: WKInterfaceLabel!
    @IBOutlet var weekLabel: WKInterfaceLabel!
    @IBOutlet var days1Label: WKInterfaceLabel!
    @IBOutlet var days2Label: WKInterfaceLabel!
    @IBOutlet var days3Label: WKInterfaceLabel!
    @IBOutlet var days4Label: WKInterfaceLabel!
    @IBOutlet var days5Label: WKInterfaceLabel!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user

        // get the current date
        let date = Date()
        let calendar = Calendar.current

        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let dayOfWeek = calendar.component(.weekday, from: date)

        // finding the previous Sunday
        var component = DateComponents()
        component.weekday = 1 - dayOfWeek
        let startingSunday = calendar.date(byAdding: component, to: date)
        let startingSundayDate = calendar.component(.day, from: startingSunday!)

        // calendar days
        let daysOfWeek = "Su Mo Tu We Th Fr Sa"

        // calendar dates
        var days1Array = ["", "", "", "", "", "", ""]
        var days2Array = ["", "", "", "", "", "", ""]
        var days3Array = ["", "", "", "", "", "", ""]
        var days4Array = ["", "", "", "", "", "", ""]
        var days5Array = ["", "", "", "", "", "", ""]

        for index in 0...6 {
            var component = DateComponents()
            component.day = index + 1 - 14 - dayOfWeek
            days1Array[index] = String(format: "%02d", calendar.component(.day, from: calendar.date(byAdding: component, to: date)!))
        }
        for index in 0...6 {
            var component = DateComponents()
            component.day = index + 1 - 7 - dayOfWeek
            days2Array[index] = String(format: "%02d", calendar.component(.day, from: calendar.date(byAdding: component, to: date)!))
        }
        for index in 0...6 {
            var component = DateComponents()
            component.weekday = index + 1 - dayOfWeek
            days3Array[index] = String(format: "%02d", calendar.component(.day, from: calendar.date(byAdding: component, to: date)!))
        }
        for index in 0...6 {
            var component = DateComponents()
            component.day = index + 1 + (7 - dayOfWeek)
            days4Array[index] = String(format: "%02d", calendar.component(.day, from: calendar.date(byAdding: component, to: date)!))
        }
        for index in 0...6 {
            var component = DateComponents()
            component.day = index + 1 + 7 + (7 - dayOfWeek)
            days5Array[index] = String(format: "%02d", calendar.component(.day, from: calendar.date(byAdding: component, to: date)!))
        }

        // creating calendar lines
        let days1String = days1Array.joined(separator: " ")
        let days2String = days2Array.joined(separator: " ")
        let days3String = days3Array.joined(separator: " ")
        let days4String = days4Array.joined(separator: " ")
        let days5String = days5Array.joined(separator: " ")

        // setting up the strings
        let daysOfWeekAttributedString = NSMutableAttributedString(string: daysOfWeek)
        let days1AttributedString = NSMutableAttributedString(string: days1String)
        let days2AttributedString = NSMutableAttributedString(string: days2String)
        let days3AttributedString = NSMutableAttributedString(string: days3String)
        days3AttributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSMakeRange((dayOfWeek - 1) * 3, 2)) // 0 4 8 12 16 20 24
        let days4AttributedString = NSMutableAttributedString(string: days4String)
        let days5AttributedString = NSMutableAttributedString(string: days5String)

        // setting the labels
        monthLabel.setText(calendar.standaloneMonthSymbols[month - 1])
        weekLabel.setAttributedText(daysOfWeekAttributedString)
        days1Label.setAttributedText(days1AttributedString)
        days2Label.setAttributedText(days2AttributedString)
        days3Label.setAttributedText(days3AttributedString)
        days4Label.setAttributedText(days4AttributedString)
        days5Label.setAttributedText(days5AttributedString)

        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

