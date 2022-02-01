//
//  ContentView.swift
//  ZCrypto
//
//  Created by Ishaan Bhasin on 11/14/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            VStack(spacing: 40){
                Text("Accent color")
                    .foregroundColor(Color.theme.accent)
                Text("secondary text")
                    .foregroundColor(Color.theme.secondary)
                Text("green")
                    .foregroundColor(Color.theme.green)
                Text("red")
                    .foregroundColor(Color.theme.red)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
