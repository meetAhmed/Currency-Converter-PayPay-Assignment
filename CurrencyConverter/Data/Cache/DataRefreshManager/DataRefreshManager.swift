//
//  DataRefreshManager.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 13/06/2023.
//

import Foundation

// This is a protocol called 'DataRefreshManager' that defines methods for managing data refresh.
protocol DataRefreshManager {
    // Returns the last fetch time as a Date object.
    // If no fetch time is available, it returns nil.
    func getLastFetchTime() -> Date?
    
    // Saves the fetch time specified by the 'time' parameter.
    func saveFetchTime(_ time: Date)
    
    // Checks the refresh status and returns a Boolean value indicating whether the data should be refreshed or not.
    func checkRefreshStatus() -> Bool
}
