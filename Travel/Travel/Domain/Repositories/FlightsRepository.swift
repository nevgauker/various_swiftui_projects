//
//  FlightsRepository.swift
//  Travel
//
//  Created by Rotem Nevgauker on 11/01/2024.
//

import Foundation


protocol FlightsRepository {
    func getAutoCompleteSuggestions(searchText:String) async ->[AutocompleteResult]?
    func getFlights(orgin:AutocompleteResult,destination:AutocompleteResult,date:Date) async ->FlightResponse?
}
