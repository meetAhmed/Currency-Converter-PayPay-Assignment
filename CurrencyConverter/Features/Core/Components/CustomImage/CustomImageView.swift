//
//  CustomImageView.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 10/06/2023.
//

import SwiftUI

struct CustomImageView: View {
    let url: URL?
     @StateObject var vm: CustomImageViewModel
    
    init(url: URL?) {
        self.url = url
        _vm = StateObject(wrappedValue: CustomImageViewModel(url: url))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                image
                    .resizable()
                    .scaledToFit()
            } else {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.theme.secondaryText)
                    .frame(width: 25, height: 25)
            }
        }
        .task {
            await vm.loadImage()
        }
    }
}

struct CustomImageView_Previews: PreviewProvider {
    static var previews: some View {
        CustomImageView(url: dev.sampleCountryFlag)
            .frame(width: 40, height: 40)
    }
}
