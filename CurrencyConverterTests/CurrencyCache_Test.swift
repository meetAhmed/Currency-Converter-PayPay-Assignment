//
//  CurrencyCache_Test.swift
//  CurrencyConverterTests
//
//  Created by Ahmed Ali on 14/06/2023.
//

@testable import CurrencyConverter
import XCTest

final class CurrencyCache_Test: XCTestCase {
    func test_CurrencyCache_saveCurrencySymbols_ShouldBeEmpty() {
        // Given
        let data: Dictionary = [:]
        
        // When
        let cache = CurrencyCacheImpl.instance
        cache.saveCurrencySymbols(data)
        
        // Then
        XCTAssertEqual(cache.getCurrencySymbols().count, 0)
    }
    
    func test_CurrencyCache_saveCurrencySymbols_ShouldNotBeEmpty() {
        // Given
        let data: Dictionary = [
            "AED": "United Arab Emirates Dirham",
            "AFN": "Afghan Afghani"
        ]
        
        // When
        let cache = CurrencyCacheImpl.instance
        cache.saveCurrencySymbols(data)
        
        // Then
        XCTAssertNotEqual(cache.getCurrencySymbols().count, 0)
    }
    
    func test_CurrencyCache_getCurrencySymbols_ShouldContainData() {
        // Given
        let data: Dictionary = [
            "AED": "United Arab Emirates Dirham",
            "AFN": "Afghan Afghani"
        ]
        let key = "AED"
        
        // When
        let cache = CurrencyCacheImpl.instance
        cache.saveCurrencySymbols(data)
        
        // Then
        XCTAssertTrue(cache.getCurrencySymbols().keys.contains(key))
    }
    
    func test_CurrencyCache_saveCurrencyRate_ShouldBeEmpty() {
        // Given
        let data: CurrencyRateDictionary = [:]
        
        // When
        let cache = CurrencyCacheImpl.instance
        cache.saveCurrencyRate(data)
        
        // Then
        XCTAssertEqual(cache.getCurrencyRate().count, 0)
    }
    
    func test_CurrencyCache_saveCurrencyRate_ShouldNotBeEmpty() {
        // Given
        let data: CurrencyRateDictionary = [
            "AED": 3.67289,
            "AFN": 86.139789
        ]
        
        // When
        let cache = CurrencyCacheImpl.instance
        cache.saveCurrencyRate(data)
        
        // Then
        XCTAssertNotEqual(cache.getCurrencyRate().count, 0)
    }
    
    func test_CurrencyCache_getCurrencyRate_ShouldContainData() {
        // Given
        let data: CurrencyRateDictionary = [
            "AED": 3.67289,
            "AFN": 86.139789
        ]
        let expectedRate = 3.67289
        
        // When
        let cache = CurrencyCacheImpl.instance
        cache.saveCurrencyRate(data)
        
        // Then
        let rateForAED = cache.getCurrencyRate()["AED"]
        XCTAssertEqual(rateForAED, expectedRate)
    }
}
