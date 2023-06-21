//
//  DataRefreshManagerImpl.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 13/06/2023.
//

import Foundation

class DataRefreshManagerImpl: DataRefreshManager {
    static let instance = DataRefreshManagerImpl()
    private init() {}
    
    private let refreshTime = 30 // minutes
    
    // Returns the last fetch time as a Date object.
    // If no fetch time is available, it returns nil.
    func getLastFetchTime() -> Date? {
        UserDefaults.standard.object(forKey: Constants.LastFetchTime) as? Date
    }
    
    // Saves the fetch time specified by the 'time' parameter.
    func saveFetchTime(_ time: Date = Date()) {
        UserDefaults.standard.set(time, forKey: Constants.LastFetchTime)
    }
    
    // Checks the refresh status and returns a Boolean value indicating whether the data should be refreshed or not.
    func checkRefreshStatus() -> Bool {
        let nowDate = Date()
        /*
         The code calculates the difference in minutes between the last fetch time and the current time using the `Calendar` class.
         It retrieves the ordinality of minutes for both dates and calculates the difference `(end - start)`.
         
         The variable `nowDate` represents the current time.
         
         The condition `(end - start) > refreshTime` compares the difference in minutes to a predefined `refreshTime` value.
         If the difference is greater than `refreshTime`, it implies that the data is due for a refresh, and the condition evaluates to `true`.
         */
        if let lastDate = getLastFetchTime() {
            let currentCalendar = Calendar.current
            let start = currentCalendar.ordinality(of: .minute, in: .era, for: lastDate) ?? 0
            let end = currentCalendar.ordinality(of: .minute, in: .era, for: nowDate) ?? 0
            return (end - start) > refreshTime
        }
        return true
    }
}
