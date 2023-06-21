//
//  CustomPicker.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 09/06/2023.
//

import SwiftUI

struct CustomPicker: View {
    @Binding var selectedValue: String
    let symbols: Dictionary
    
    var body: some View {
        Picker("", selection: $selectedValue) {
            pickerContent
        }
        .labelsHidden()
        .foregroundColor(.theme.secondaryText)
        .pickerStyle(.navigationLink)
        .padding()
        .overlay(alignment: .trailing) {
            Image(systemName: "chevron.right")
                .font(.caption)
                .padding(.trailing)
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.theme.background)
        )
    }
}

struct CustomPicker_Previews: PreviewProvider {
    static var previews: some View {
        CustomPicker(selectedValue: .constant(""), symbols: dev.symbols)
    }
}

private extension CustomPicker {
    var pickerContent: some View {
        ForEach(symbols.keys.sorted(), id: \.self) { key in
            HStack(spacing: 10) {
                CustomImageView(
                    url: CountryFlagHelper.instance.getCountryFlagUrl(
                        currencyName: symbols[key].stringValue
                    )
                )
                .frame(width: 35, height: 35)
                
                Text(key)
                    .minimumScaleFactor(0.1)
                    .foregroundColor(.theme.accent)
                    .fontWeight(.bold)
                
                Spacer()
            }
        }
    }
}
