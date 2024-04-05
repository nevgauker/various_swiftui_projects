//
//  MockFlightsRepository.swift
//  TravelTests
//
//  Created by Rotem Nevgauker on 11/01/2024.
//
@testable import Travel
import Foundation

class MockFlightsRepository: FlightsRepository {
    func getFlights(orgin: Travel.AutocompleteResult, destination: Travel.AutocompleteResult, date: Date) -> FlightResponse? {
        return nil
    }
    

//    let mockFlights Respose = FlightResponse(sessionToken: <#T##String#>, status: <#T##String#>, action: <#T##String#>, content: <#T##Content#>)
    var autoCompleteSuggestions =  [AutocompleteResult(cityName: "test city", countryName: "test country", name: "test text", location: "test location", type: "test type", iataCode: "test code", entityId: "test enitityid")]
    
    var receivedGetFlightsParameters: (origin: AutocompleteResult, destination: AutocompleteResult, date: Date)?
    var flightResponse: FlightResponse?
    
    func getAutoCompleteSuggestions(searchText: String) -> [AutocompleteResult]? {
        return autoCompleteSuggestions
    }
    func getNoAutoCompleteSuggestions(searchText: String) -> [AutocompleteResult]? {
        return []
    }
    
    func getAutoCompleteSuggestionsErrpor(searchText: String) -> [AutocompleteResult]? {
        return nil
    }
//    func getMockFlights(orgin: Travel.AutocompleteResult, destination: Travel.AutocompleteResult, date: Date) -> FlightResponse? {
//         return nil
//    }
}
