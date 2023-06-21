//
//  CountryFlagHelper_Test.swift
//  CurrencyConverterTests
//
//  Created by Ahmed Ali on 14/06/2023.
//

@testable import CurrencyConverter
import XCTest

final class CountryFlagHelper_Test: XCTestCase {
    func test_CountryFlagHelper_getCountryFlagUrl_ShouldReturnFlagUrl() {
        // Given
        let currencyName = "Pakistani Rupee"
        
        // When
        let countryFlagHelper = CountryFlagHelper.instance
        
        // Then
        XCTAssertNotNil(countryFlagHelper.getCountryFlagUrl(currencyName: currencyName))
    }
    
    // invalid currency name
    func test_CountryFlagHelper_getCountryFlagUrl_ShouldReturnNil() {
        // Given
        let currencyName = "Invalid Currency"
        
        // When
        let countryFlagHelper = CountryFlagHelper.instance
        
        // Then
        XCTAssertNil(countryFlagHelper.getCountryFlagUrl(currencyName: currencyName))
    }
}
