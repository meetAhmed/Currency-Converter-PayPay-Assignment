//
//  ConverterView.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 09/06/2023.
//

import Combine
import SwiftUI

struct ConverterView: View {
    @StateObject var vm = ConverterViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                currencySelectorView
                
                amountInputView
                
                convertButtonView
                
                convertedRatesView
            }
            .navigationTitle("Currency Converter")
            .padding()
            .task {
                await vm.fetchData()
            }
        }
    }
}

struct ConverterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ConverterView()
        }
    }
}

private extension ConverterView {
    var currencySelectorView: some View {
        HStack(alignment: .center, spacing: 10) {
            VStack {
                CustomPicker(selectedValue: $vm.pickerFromValue, symbols: vm.currencySymbols)
            }
            
            Image(systemName: "arrow.right")
            
            CustomPicker(selectedValue: $vm.pickerToValue, symbols: vm.currencySymbols)
        }
    }
    
    var amountInputView: some View {
        HStack {
            TextField("Amount", text: $vm.amountTextField)
        }
        .padding()
        .background(Color.theme.background)
        .cornerRadius(15)
    }
    
    var convertButtonView: some View {
        Button {
            vm.performCalculation()
            vm.amountTextField = ""
        } label: {
            Text("Convert")
                .foregroundColor(.white)
                .fontWeight(.heavy)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.blue.opacity(vm.opacityForConvertBtn))
                )
        }
        .disabled(vm.opacityForConvertBtn != 1)
    }
    
    var convertedRatesView: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
            ForEach(vm.convertedCurrency, id: \.self) { convertedCurrency in
                ConvertedCurrencyView(convertedCurrency: convertedCurrency)
            }
        }
    }
}
