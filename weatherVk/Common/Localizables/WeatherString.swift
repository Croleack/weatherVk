//
//  WeatherString.swift
//  weatherVk
//
//  Created by test on 22.07.2024.
//

import Foundation

enum WeatherString: String {
    case weatherLabel    
    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)",
                          comment: "")
    }
}
 
