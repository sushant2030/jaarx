//
//  PreOrderViewModel.swift
//  Jaarx
//
//  Created by Sushant Alone on 27/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation

struct PreOrderViewModel : RowViewModel {
    var numberOfPeople : Int?
    var bookingDate : String?
    var bookingTime : String?
    var time : String?
    var resId : Int?
    var noOfPerson : Int?
    var orderId : Int?
    var startDate = Date()
    var requiredDates = Observable<[Day]> (value: [])
    var timeMode : TimeMode = Helper.getCurrentTimeMode()
    var tableImage = Observable<String> (value: "2table")
    
    func getNumberOfTables() -> Int {
        return 10
    }
    
    mutating func changeStartDate(date : Date)  {
        self.startDate = date
        setNext10Days()
    }
    
    mutating func pickBookingTime(date : Date)  {
        time = date.changeUTCToLocal(date: date)
        updateTime()
        
    }
    
    mutating func setNumberOfPeopleWith(tableNo : Int) {
        numberOfPeople = tableNo
        if tableNo < 3 {
            tableImage.value = "\(2)table"
        } else if tableNo < 5 {
            tableImage.value = "\(4)table"
        } else if tableNo < 7 {
            tableImage.value = "\(6)table"
        } else if tableNo < 9 {
            tableImage.value = "\(8)table"
        } else {
            tableImage.value = "\(10)table"
        }
    }
    
    mutating func changeTimeMode(mode : TimeMode) {
        timeMode = mode
        if let _ = bookingTime {
            updateTime()
        }
    }
    
    private mutating func updateTime() {
        switch timeMode {
        case .am:
            bookingTime = time! + " am"
        default:
            bookingTime = time! + " pm"
        }
    }

    
    mutating func setNext10Days()  {
        let cal = Calendar.current
        var date = cal.startOfDay(for: startDate)
        let weekdays = ["Sun","Mon","Tue","Wed","Thur","Fri","Sat"]
        var days = [Day]()

        for _ in 1 ... 10 {
            // get day component:
            let day = cal.component(.day, from: date)
            let weekDay = cal.component(.weekday, from: date)
            let dayName = weekdays[weekDay - 1]
            let dayObject = Day.init(day: day, dayTitle: dayName, date: date, dateString: Date.getDateInString(date: date))
            days.append(dayObject)
            // move back in time by one day:
            date = cal.date(byAdding: .day, value: 1, to: date)!
        }
        requiredDates.value = days
    }
    
}

struct Day {
    let day : Int
    let dayTitle : String
    let date : Date
    let dateString : String
}
