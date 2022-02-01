//
//  Color.swift
//  ZCrypto
//
//  Created by Ishaan Bhasin on 11/14/21.
//

import Foundation
import SwiftUI

extension Color{
    static let theme = ColorTheme()
}

struct ColorTheme{
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondary = Color("SecondaryTextColor")
    let primary = Color("PrimaryColor")
}

