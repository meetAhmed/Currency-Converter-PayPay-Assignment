//
//  DataRefreshManager_Test.swift
//  CurrencyConverterTests
//
//  Created by Ahmed Ali on 14/06/2023.
//

@testable import CurrencyConverter
import XCTest

final class DataRefreshManager_Test: XCTestCase {
    func test_DataRefreshManager_saveFetchTime_ShouldSaveTime() {
        // Given
        let time = Date()
        
        // When
        let dataRefreshManager = DataRefreshManagerImpl.instance
        dataRefreshManager.saveFetchTime()
        
        // Then
        let result = Calendar.current.isDate(time, equalTo: dataRefreshManager.getLastFetchTime() ?? Date(), toGranularity: .minute)
        XCTAssertTrue(result)
    }
    
    func test_DataRefreshManager_checkRefreshStatus_ShouldBeTrue() {
        // Given
        let lastFetchDateComponents = DateComponents(year: 2023, month: 6, day: 12, hour: 09, minute: 50) // 1 day old
        let lastFetchDate = Calendar.current.date(from: lastFetchDateComponents) ?? Date()
        
        // When
        let dataRefreshManager = DataRefreshManagerImpl.instance
        dataRefreshManager.saveFetchTime(lastFetchDate)
        
        // Then
        XCTAssertTrue(dataRefreshManager.checkRefreshStatus())
    }
    
    func test_DataRefreshManager_checkRefreshStatus_ShouldBeFalse() {
        // Given
        let time = Date()
        
        // When
        let dataRefreshManager = DataRefreshManagerImpl.instance
        dataRefreshManager.saveFetchTime(time)
        
        // Then
        XCTAssertFalse(dataRefreshManager.checkRefreshStatus())
    }
}
