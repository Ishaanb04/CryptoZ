//
//  Double.swift
//  ZCrypto
//
//  Created by Ishaan Bhasin on 11/21/21.
//

import Foundation

extension Double{
    
    /// Converts a Double into a currency with 2 decimal places
    /// ```
    /// Convert 1234.5633 to $1,234.56
    /// ```
    private var currencyFormater2: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func asCurrencyWith2Decimal()-> String{
        let number = NSNumber(value: self)
        return currencyFormater2.string(from: number) ?? "$0.00"
    }
    
    /// Converts a Double into a currency with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// Convert 1234.56 to $1,234.56
    /// ```
    private var currencyFormater6: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    func asCurrencyWith6Decimal()-> String{
        let number = NSNumber(value: self)
        return currencyFormater6.string(from: number) ?? "$0.00"
    }
    
    /// Converts a Double into a string representation
    /// ```
    /// Convert 1.23456 to "1.23"
    /// ```
    func asNumberString() ->String{
        return String(format: "%.2f", self)
    }
    
    /// Converts a Double into a string representation with percentage sign
    /// ```
    /// Convert 1.23456 to "1.23%"
    /// ```
    func asPercentString() -> String{
        return asNumberString() + "%"
    }
}
