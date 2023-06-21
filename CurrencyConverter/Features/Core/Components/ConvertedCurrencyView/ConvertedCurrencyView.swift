//
//  ConvertedCurrencyView.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 13/06/2023.
//

import SwiftUI

struct ConvertedCurrencyView: View {
    let convertedCurrency: ConvertedCurrency
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 20) {
                CustomImageView(
                    url: CountryFlagHelper.instance.getCountryFlagUrl(
                        currencyName: convertedCurrency.currencyFromTitle
                    )
                )
                .frame(width: 25, height: 25)
                
                Image(systemName: "arrow.right")
                    .font(.caption)
                
                CustomImageView(
                    url: CountryFlagHelper.instance.getCountryFlagUrl(
                        currencyName: convertedCurrency.currencyToTitle
                    )
                )
                .frame(width: 25, height: 25)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(convertedCurrency.currencyFrom)
                    Text(convertedCurrency.amountFrom.formatAmount())
                }
                Image(systemName: "arrow.right")
                    .font(.caption)
                VStack(alignment: .leading) {
                    Text(convertedCurrency.currencyTo)
                    Text(convertedCurrency.amountTo.formatAmount())
                }
            }
        }
        .padding()
        .background(Color.theme.background)
        .cornerRadius(20)
    }
}

struct ConvertedCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        ConvertedCurrencyView(convertedCurrency: dev.convertedCurrency)
    }
}
