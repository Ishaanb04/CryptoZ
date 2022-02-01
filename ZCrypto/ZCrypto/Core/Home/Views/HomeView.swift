//
//  HomeView.swift
//  ZCrypto
//
//  Created by Ishaan Bhasin on 11/14/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var startVm: StartHomeViewModel
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPorfolioView: Bool = false
    @State private var showPortfolio: Bool = false
    @State var isLogedIn: Bool = false
    var body: some View {
        if startVm.signedIn{
            ZStack{
                // Background layer
                Color.theme.background
                    .ignoresSafeArea()
                    .sheet(isPresented: $showPorfolioView, content: {
                    
                        PortfolioView()
                            .environmentObject(vm)
                    })

                
                // Content layer
                VStack{
                    homeHeader
                    SearchBarView(searchText: $vm.searchText)
                    columnTitle
                    if !showPortfolio{
                        allcoinsList
                            .transition(.move(edge: .leading))
                    }
                    if showPortfolio{
                        portfolioCoinsList
                            .transition(.move(edge: .trailing))
                    }
                    Spacer(minLength: 0)
                    
                }
            }
        }else{
            StartHomeView()
                .onAppear {
                    startVm.signedIn = startVm.isSignedIn
                    showPortfolio = false
                }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(dev.homeVM)
            .preferredColorScheme(.dark)
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(dev.homeVM)
        }
    }
}


extension HomeView{
    private var homeHeader: some View {
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
                .onTapGesture {
                    if showPortfolio{
                        showPorfolioView.toggle()
                    }
                }
            
            
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()){
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allcoinsList: some View{
        List{
            ForEach(vm.allCoins){coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinsList: some View{
        VStack{
            List{
                ForEach(vm.portfolioCoins){coin in
                    CoinRowView(coin: coin, showHoldingColumn: true)
                        .listRowInsets(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                }
            }
            .listStyle(PlainListStyle())
            Button {
                startVm.signout()
                startVm.signedIn = startVm.isSignedIn
            } label: {
                   Text("Sign Out")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.theme.accent)
                    .background(Color.theme.background)
            }

        }
        
    }
    
    private var columnTitle: some View{
        HStack{
            Text("Coin")
            Spacer()
            if showPortfolio{
                Text("Holdings")

            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondary)
        .padding(.horizontal)
    }
}
