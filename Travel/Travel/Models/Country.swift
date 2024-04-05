//
//  Country.swift
//  Travel
//
//  Created by Rotem Nevgauker on 12/11/2023.
//

import Foundation

struct Country: Decodable {
    var id:UUID = UUID()
    let name: String
    // Add other properties as needed
}
