//
//  CoinDataService.swift
//  ZCrypto
//
//  Created by Ishaan Bhasin on 11/22/21.
//

import Foundation
import Combine

class CoinDataService{
    @Published var allCoins: [Coin] = []
    var coinSubscription: AnyCancellable?
    init(){
        getCoins()
    }
    
    private func getCoins(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {return}
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink { (completion) in
                NetworkingManager.handleCompletion(completion: completion)
            } receiveValue: { [weak self] (returnedCoins) in
                guard let self = self else{return}
                self.allCoins = returnedCoins
                self.coinSubscription?.cancel()
            }
            
    }
}
