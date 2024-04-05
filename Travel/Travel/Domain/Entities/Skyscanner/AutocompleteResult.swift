//
//  AutocompleteResult.swift
//  Travel
//
//  Created by Rotem Nevgauker on 11/01/2024.
//

import Foundation

struct AutocompleteResult:Codable,Hashable {
    let cityName:String?
    let countryName:String?
    let name:String?
    let location:String?
    let type:String?
    let iataCode:String
    let entityId:String
    
    var iconName:String{
        if let t = type{
            switch t {
            case "PLACE_TYPE_CITY":
                return "city"
            case "PLACE_TYPE_COUNTRY":
                return "country"
            case "PLACE_TYPE_AIRPORT":
                return "airport"
            default:
                break
            }
        }
        return ""
    }
}
