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

    @IBOutlet var dayTable: WKInterfaceTable!

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


////////////TODO
        // - before and after rows
        // - scroll to keep the current week in the middle of the screen when the app is activated/opened
        // - put in the month names
        // - for the last and first week in the months
        //    - gray out the other months days
        //    - repeat the week for each month

        let numberOfMonths = 6
        var monthIndex = 0
        var calendarArray = [CalendarLine]()
        var weekIndex = -10

        while monthIndex < numberOfMonths {
            var daysArray = ["", "", "", "", "", "", ""]
            var isStartOfMonth = false
            var component = DateComponents()

            for dayIndex in 0...6 {
                component.day = dayIndex + 1 + (7 * weekIndex) + (7 - dayOfWeek)
                let dayNumber = calendar.component(.day, from: calendar.date(byAdding: component, to: date)!)

                if (dayNumber == 1) {
                    isStartOfMonth = true
                }

                daysArray[dayIndex] = String(format: "%02d", dayNumber)
            }

            if (isStartOfMonth) {
                monthIndex += 1
                let daysString = daysArray.joined(separator: " ")
                let month = calendar.component(.month, from: calendar.date(byAdding: component, to: date)!)
                let monthString = calendar.standaloneMonthSymbols[month - 1]
                calendarArray.append(CalendarLine(lineType: "day", contents: daysString))
                calendarArray.append(CalendarLine(lineType: "month", contents: monthString))
                calendarArray.append(CalendarLine(lineType: "weekdays", contents: "SU MO TU WE TH FR SA"))
                calendarArray.append(CalendarLine(lineType: "day", contents: daysString))
            }
            else {
                let daysString = daysArray.joined(separator: " ")
                calendarArray.append(CalendarLine(lineType: "day", contents: daysString))
            }

            isStartOfMonth = false
            weekIndex += 1
        }


        var tableRowTypes = [String]()
        for rowIndex in 0 ..< calendarArray.count {
            switch (calendarArray[rowIndex].lineType) {
            case "day":
                tableRowTypes.append("Days")
                break
            case "month":
                tableRowTypes.append("Month")
                break
            default:
                tableRowTypes.append("Days")
                break
            }

        }

        dayTable.setRowTypes(tableRowTypes)
        for rowIndex in 0 ..< calendarArray.count {
            switch (calendarArray[rowIndex].lineType) {
            case "month":
                let string = NSMutableAttributedString(string: calendarArray[rowIndex].contents)
                let row = dayTable.rowController(at: rowIndex) as! MonthRowController
                row.label.setAttributedText(string)
                break
            case "day":
                let string = NSMutableAttributedString(string: calendarArray[rowIndex].contents)
                let row = dayTable.rowController(at: rowIndex) as! DayRowController
                row.label.setAttributedText(string)
                break
            case "weekdays": //maybe create a weekday row controller
                let string = NSMutableAttributedString(string: calendarArray[rowIndex].contents)
                let row = dayTable.rowController(at: rowIndex) as! DayRowController
                row.label.setAttributedText(string)
                break
            default:
                break
            }
        }

        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

