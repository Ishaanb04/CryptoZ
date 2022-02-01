//
//  PortfolioView.swift
//  ZCrypto
//
//  Created by Ishaan Bhasin on 11/27/21.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var startVm: StartHomeViewModel
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: Coin? = nil
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading, spacing: 0){
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil{
                        VStack(spacing: 20){
                            HStack{
                                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                                Spacer()
                                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimal() ?? "")
                            }
                        }
                        .padding()
                    }
                    
                }
                .navigationTitle("Edit Portfolio")
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "xmark")
                        })
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack{
                            Image(systemName: "checkmark")
                            Button {
                                saveButtonPressed()
                            } label: {
                                Text("save".uppercased())
                            }
                            
                            
                        }
                        .font(.headline)
                        
                    }
                })
                
            }
        }
        
    }
    
    private func saveButtonPressed(){
        guard let coin = selectedCoin else {
            return
        }
        var isPresent: Bool = false
        for theCoin in vm.portfolioCoins{
            if theCoin.id == coin.id{
                isPresent = true
            }
        }
        if isPresent{
            presentationMode.wrappedValue.dismiss()
        }else{
            vm.portfolioCoins.append(coin)
            presentationMode.wrappedValue.dismiss()
        }
        
        
    }
}

extension PortfolioView{
    private var coinLogoList: some View{
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10){
                ForEach(vm.allCoins){coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(5)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
                            
                        )
                }
            }
            .padding(.vertical, 10)
            .padding(.leading)
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}
