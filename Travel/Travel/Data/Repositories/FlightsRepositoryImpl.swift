//
//  FlightsRepositoryImpl.swift
//  Travel
//
//  Created by Rotem Nevgauker on 11/01/2024.
//

import Foundation


struct FlightsRepositoryImpl:FlightsRepository{
    func getAutoCompleteSuggestions(searchText: String) async -> [AutocompleteResult]? {
        return nil
    }
    
    func getFlights(orgin: AutocompleteResult, destination: AutocompleteResult, date: Date)  async -> FlightResponse? {
        nil
    }
 
}
