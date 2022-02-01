//
//  ZCryptoApp.swift
//  ZCrypto
//
//  Created by Ishaan Bhasin on 11/14/21.
//

import SwiftUI
import Firebase

@main
struct ZCryptoApp: App {
    @StateObject private var vm: HomeViewModel = HomeViewModel()
    @StateObject private var startVm: StartHomeViewModel = StartHomeViewModel()
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(startVm)
            .environmentObject(vm)
        }
    }
}
