//
//  ConverterViewModel_Test.swift
//  CurrencyConverterTests
//
//  Created by Ahmed Ali on 14/06/2023.
//

@testable import CurrencyConverter
import XCTest

final class ConverterViewModel_Test: XCTestCase {
    func test_ConverterViewModel_opacityForConvertBtn_shouldBe_1() {
        // Given
        let opacity = 1.0
        
        // When
        let viewModel = ConverterViewModel()
        viewModel.amountTextField = "12.05"
        
        // Then
        XCTAssertEqual(opacity, viewModel.opacityForConvertBtn)
    }
    
    // empty amount
    func test_ConverterViewModel_opacityForConvertBtn_shouldBe_Zero_Point_Four() {
        // Given
        let opacity = 0.4
        
        // When
        let viewModel = ConverterViewModel()
        
        // Then
        XCTAssertEqual(opacity, viewModel.opacityForConvertBtn)
    }
    
    func test_ConverterViewModel_currencySymbols_shouldNotBeEmpty() {
        // When
        CurrencyCacheImpl.instance.saveCurrencySymbols(["AUD": "Australian Dollar"])
        let viewModel = ConverterViewModel()
        
        // Then
        XCTAssertFalse(viewModel.currencySymbols.isEmpty)
    }
    
    func test_ConverterViewModel_getConvertedValue_shouldNotZero() {
        // When
        CurrencyCacheImpl.instance.saveCurrencyRate(
            [
                "AED": 3.67289,
                "AFN": 86.139789
            ]
        )
        
        let viewModel = ConverterViewModel()
        viewModel.amountTextField = "12.05"
        viewModel.pickerFromValue = "AFN"
        viewModel.pickerToValue = "AED"
        
        // Then
        XCTAssertNotEqual(viewModel.getConvertedValue(), 0)
    }
    
    // Invalid amount
    func test_ConverterViewModel_getConvertedValue_shouldBeZero() {
        // When
        CurrencyCacheImpl.instance.saveCurrencyRate(
            [
                "AED": 3.67289,
                "AFN": 86.139789
            ]
        )
        
        let viewModel = ConverterViewModel()
        viewModel.amountTextField = "ABCD"
        viewModel.pickerFromValue = "AFN"
        viewModel.pickerToValue = "AED"
        
        // Then
        XCTAssertEqual(viewModel.getConvertedValue(), 0)
    }
}
