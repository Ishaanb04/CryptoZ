//
//  CoinImageService.swift
//  ZCrypto
//
//  Created by Ishaan Bhasin on 11/22/21.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService{
    @Published var image: UIImage? = nil
    var imageSubscribtion: AnyCancellable?
    private let coin: Coin
    init(coin: Coin){
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage(){
        guard let url = URL(string: coin.image) else {return}
        imageSubscribtion = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink { (completion) in
                NetworkingManager.handleCompletion(completion: completion)
            } receiveValue: { [weak self] (returnedImage) in
                guard let self = self else{return}
                self.image = returnedImage
                self.imageSubscribtion?.cancel()
            }
    }
}
