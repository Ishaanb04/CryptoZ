//
//  CoinImageViewModel.swift
//  ZCrypto
//
//  Created by Ishaan Bhasin on 11/22/21.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject{
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    private var cancelables: Set<AnyCancellable> = Set<AnyCancellable>()
    private let coin: Coin
    private let dataService: CoinImageService
    init(coin: Coin){
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers(){
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancelables)
    }
}
