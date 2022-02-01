//
//  HomeViewModel.swift
//  ZCrypto
//
//  Created by Ishaan Bhasin on 11/21/21.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(){
        addSubsribers()
    }
    
    func addSubsribers(){
        
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map{ (text, startingCoins) -> [Coin] in
                guard !text.isEmpty else{
                    return startingCoins
                }
                let lowerCased = text.lowercased()
                let filteredCoins = startingCoins.filter { coin in
                    coin.name.lowercased().contains(lowerCased) || coin.symbol.lowercased().contains(lowerCased) || coin.id.lowercased().contains(lowerCased)
                }
                return filteredCoins
            }
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
    }
}
