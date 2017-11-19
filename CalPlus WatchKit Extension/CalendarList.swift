//
//  CalendarList.swift
//  CalPlus WatchKit Extension
//
//  Created by Jared Poetter on 11/19/17.
//  Copyright © 2017 Jared Poetter. All rights reserved.
//

import WatchKit

class CalendarList: NSObject {

    override init() {
        super.init()
    }

    func monthList(date: Date, monthsBefore: Int, monthsAfter: Int) -> [CalendarLine] {
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: date)

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

        return calendarArray
    }

}
