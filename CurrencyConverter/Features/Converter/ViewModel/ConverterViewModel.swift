//
//  ConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 09/06/2023.
//

import Combine
import Foundation

/**
 This is a class called 'ConverterViewModel' that conforms to the 'ObservableObject' protocol.
 The class is intended to be used as a view model for a converter feature.
 The 'ObservableObject' protocol allows the class to be observed for changes, enabling reactive behavior when its properties are updated.
 */
class ConverterViewModel: ObservableObject {
    let service = NetworkService.init()
    let localCache: CurrencyCache = CurrencyCacheImpl.instance
    var cancellabels: Set<AnyCancellable> = []
    
    @Published var currencySymbols: Dictionary = [:]
    @Published var currencyRate: CurrencyRateDictionary = [:]
    @Published var convertedCurrency: [ConvertedCurrency] = []
    @Published var pickerToValue = ""
    @Published var pickerFromValue = ""
    @Published var amountTextField = ""
    @Published var opacityForConvertBtn = 0.0
    
    /**
     This is an initializer for the 'ConverterViewModel' class.
     
     The initializer sets up the initial state of the view model by performing the following steps:
     
     1. Retrieves the cached currency symbols and currency rates using the 'getCurrencySymbols()' and 'getCurrencyRate()' methods of the 'localCache' object.
     
     2. Initializes the 'pickerFromValue' property with the first currency symbol from the sorted keys of the 'currencySymbols' dictionary.
     If the 'currencySymbols' dictionary is empty, the 'pickerFromValue' is set to an empty string.
     
     3. Initializes the 'pickerToValue' property with the second currency symbol from the sorted keys of the 'currencySymbols' dictionary, if it contains more than one currency symbol.
     If the 'currencySymbols' dictionary has only one currency symbol, the 'pickerToValue' is set to the same value as 'pickerFromValue'.
     
     4. Sets up a sink on the 'amountTextField' property, which listens for changes to the text value.
     When the text value changes, the sink closure is executed, and the 'opacityForConvertBtn' property is updated based on whether the trimmed text is empty or not.
     If the trimmed text is empty, the opacity is set to 0.4; otherwise, it is set to 1.0.
     
     5. The cancellable returned by the sink is stored in the 'cancellabels' collection to ensure it remains in memory and can be canceled if needed.
     */
    init() {
        currencySymbols = localCache.getCurrencySymbols()
        currencyRate = localCache.getCurrencyRate()
        
        pickerFromValue = currencySymbols.keys.sorted().first ?? ""
        pickerToValue = currencySymbols.count > 1 ? currencySymbols.keys.sorted()[1] : pickerFromValue
        
        $amountTextField.sink { text in
            self.opacityForConvertBtn = text.trim().isEmpty ? 0.4 : 1.0
        }
        .store(in: &cancellabels)
    }
    
    /**
     This is an asynchronous method called 'fetchData()' that fetches currency symbols and rates.
     
     The method performs the following steps:
     
     1. Checks the refresh status by calling the 'checkRefreshStatus()' method of the 'DataRefreshManagerImpl' instance.
     The implementation of the refresh status check depends on the specific logic provided by the 'DataRefreshManagerImpl' class.
     
     2. If the refresh status indicates that the data needs to be refreshed, the following actions are performed:
     - Saves the fetch time by calling the 'saveFetchTime()' method of the 'DataRefreshManagerImpl' instance.
     - Asynchronously fetches the currency symbols by calling the 'fetchCurrencySymbols()' method (presumably an asynchronous operation).
     - Asynchronously fetches the currency rates by calling the 'fetchCurrencyRates()' method (presumably an asynchronous operation).
     
     3. If the refresh status indicates that the data has been fetched within the last 30 minutes, a message is printed indicating that the data is already up to date.
     */
    func fetchData() async {
        if DataRefreshManagerImpl.instance.checkRefreshStatus() {
            DataRefreshManagerImpl.instance.saveFetchTime()
            await fetchCurrencySymbols()
            await fetchCurrenyRates()
        } else {
            print("Data: Already fetched within last 30 minutes.")
        }
    }
    
    /**
     This is an asynchronous method called 'fetchCurrencySymbols()' that fetches currency symbols.
     
     The method is marked with the '@MainActor' attribute, indicating that it should be executed on the main actor to ensure thread safety and compatibility with SwiftUI views.
     
     The method performs the following steps:
     
     1. Attempts to execute a network request to fetch currency symbols by calling the 'executeRequest(for:)' method of the 'service' object.
     The 'executeRequest(for:)' method is passed an 'APIConstructor' object with the 'endpoint' set to '.currencySymbols', indicating the specific API endpoint to fetch currency symbols.
     
     2. If the network request is successful and the symbols are received, the following actions are performed:
     - Saves the fetched currency symbols to the local cache by calling the 'saveCurrencySymbols(_ symbols: Dictionary)' method of the 'localCache' object.
     - Updates the 'currencySymbols' property with the fetched symbols.
     
     3. If an error occurs during the network request or any other step, the error is printed to the console.
     */
    @MainActor
    func fetchCurrencySymbols() async {
        do  {
            let symbols: [String: String] = try await service.executeRequest(for: .init(endpoint: .currencySymbols))
            localCache.saveCurrencySymbols(symbols)
            currencySymbols = symbols
        } catch {
            print("getSymbols: \(error)")
        }
    }
    
    /**
     This is an asynchronous method called 'fetchCurrencyRates()' that fetches currency rates.
     
     The method is marked with the '@MainActor' attribute, indicating that it should be executed on the main actor to ensure thread safety and compatibility with SwiftUI views.
     
     The method performs the following steps:
     
     1. Attempts to execute a network request to fetch currency rates by calling the 'executeRequest(for:)' method of the 'service' object.
     The 'executeRequest(for:)' method is passed an 'APIConstructor' object with the 'endpoint' set to '.currencyRates', indicating the specific API endpoint to fetch currency rates.
     
     2. If the network request is successful and the rates are received, the following actions are performed:
     - Saves the fetched currency rates to the local cache by calling the 'saveCurrencyRate(_ rate: CurrencyRateDictionary)' method of the 'localCache' object.
     - Updates the 'currencyRate' property with the fetched rates.
     
     3. If an error occurs during the network request or any other step, the error is printed to the console.
     */
    @MainActor
    func fetchCurrenyRates() async {
        do  {
            let currencyRate: CurrencyRate = try await service.executeRequest(for: .init(endpoint: .currencyRates))
            localCache.saveCurrencyRate(currencyRate.rates)
            self.currencyRate = currencyRate.rates
        } catch {
            print("getSymbols: \(error)")
        }
    }
    
    /**
     This is a method called 'performCalculation()' that performs a currency conversion calculation.
     
     The method performs the following steps:
     
     1. Retrieves the converted value by calling the 'getConvertedValue()' method.
     
     2. Appends a new instance of a 'ConvertedCurrency' struct to the 'convertedCurrency' array.
     The 'ConvertedCurrency' struct is initialized with the following parameters:
     - 'currencyFrom': The selected currency symbol from the 'pickerFromValue'.
     - 'currencyFromTitle': The corresponding currency title retrieved from the 'currencySymbols' dictionary using the 'pickerFromValue'.
     - 'currencyTo': The selected currency symbol from the 'pickerToValue'.
     - 'currencyToTitle': The corresponding currency title retrieved from the 'currencySymbols' dictionary using the 'pickerToValue'.
     - 'amountFrom': The amount entered in the 'amountTextField' property, converted to a double value.
     - 'amountTo': The calculated converted value obtained from the 'getConvertedValue()' method.
     
     1 USD = 3.6 AED
     1 USD = 85.76 AFN
     transitive relation
     3.6 AED = 85.76 AFN
     1 AED = 85.76/3.6
     */
    func performCalculation() {
        let value = getConvertedValue()
        convertedCurrency.append(
            .init(
                currencyFrom: pickerFromValue,
                currencyFromTitle: currencySymbols[pickerFromValue].stringValue,
                currencyTo: pickerToValue,
                currencyToTitle: currencySymbols[pickerToValue].stringValue,
                amountFrom: amountTextField.asDouble,
                amountTo: value
            )
        )
    }
    
    /**
     This is a method called 'getConvertedValue()' that calculates the converted currency value.
     
     The method performs the following steps:
     
     1. Checks if the currency rate exists for both the selected 'pickerFromValue' and 'pickerToValue'.
     It also checks if the rates are greater than zero and if the 'amountTextField' contains a valid double value.
     If any of these conditions are not met, the method returns 0.0 as the converted value.
     
     2. Calculates the conversion rate by dividing the 'pickerTo' rate by the 'pickerFrom' rate.
     
     3. Calculates the converted value by multiplying the 'amountTextField' value with the conversion rate.
     
     The method returns the calculated converted value as a double.
     */
    func getConvertedValue() -> Double {
        guard let pickerFrom = currencyRate[pickerFromValue],
              let pickerTo = currencyRate[pickerToValue],
              pickerFrom > 0.0,
              amountTextField.asDouble > 0.0
        else { return 0.0 }
        let rate = pickerTo / pickerFrom
        return amountTextField.asDouble * rate
    }
}
