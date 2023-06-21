//
//  NetworkService_Test.swift
//  CurrencyConverterTests
//
//  Created by Ahmed Ali on 14/06/2023.
//

@testable import CurrencyConverter
import XCTest

final class NetworkService_Test: XCTestCase {
    func test_NetworkService_ShouldDownloadSymbolData() async throws {
        // Given
        let networkService = NetworkService.init()
        let expectedKey = "PKR"
        
        // When
        let data: Dictionary = try await networkService.executeRequest(for: .init(endpoint: .currencySymbols))
        
        XCTAssertFalse(data.isEmpty)
        XCTAssertTrue(data.keys.contains(expectedKey))
    }
    
    func test_NetworkService_ShouldDownloadCurrencyRate() {
        // Given
        let networkService = NetworkService.init()
        
        // When
        let expectation = XCTestExpectation(description: "Downloads data")
        
        Task {
            do {
                let _: CurrencyRate = try await networkService.executeRequest(for: .init(endpoint: .currencyRates))
                expectation.fulfill()
            } catch {
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
}
