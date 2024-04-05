//
//  FlightsRepositoryTests.swift
//  TravelTests
//
//  Created by Rotem Nevgauker on 11/01/2024.
//
@testable import Travel

import XCTest

final class FlightsRepositoryTests: XCTestCase {

    
    class MockFlightsRepository: FlightsRepository {
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
        
        
        func getFlights(orgin: AutocompleteResult, destination: AutocompleteResult, date: Date) -> FlightResponse? {
            receivedGetFlightsParameters = (orgin, destination, date)
            return flightResponse
        }
    }
    
    func testGetAutoCompleteSuggestions() {
      
        let mockRepository = MockFlightsRepository()
        let expectedSuggestions = [AutocompleteResult(cityName: "test city", countryName: "test country", name: "test text", location: "test location", type: "test type", iataCode: "test code", entityId: "test enitityid")]
        mockRepository.autoCompleteSuggestions = expectedSuggestions
        let result = mockRepository.getAutoCompleteSuggestions(searchText: "test text")
        XCTAssertEqual(result, expectedSuggestions)
    }
    
    func testEmptyGetAutoCompleteSuggestions() {
        
        let mockRepository = MockFlightsRepository()
        let expectedSuggestions:[AutocompleteResult] = []
        mockRepository.autoCompleteSuggestions = expectedSuggestions
        let result = mockRepository.getNoAutoCompleteSuggestions(searchText: "test text")
        XCTAssertEqual(result, expectedSuggestions)
    }
    
    func testErroryGetAutoCompleteSuggestions() {
        let mockRepository = MockFlightsRepository()
        let result = mockRepository.getAutoCompleteSuggestionsErrpor(searchText: "test text")
        XCTAssertNil(result)
    }
    
    
    
//    func testGetFlights() {
//        // Arrange
//        let mockRepository = MockFlightsRepository()
//        let origin = AutocompleteResult(cityName: "test city", countryName: "test country", name: "test text", location: "test location", type: "test type", iataCode: "test code", entityId: "test enitityid")
//        
//        let destination = AutocompleteResult(cityName: "test city", countryName: "test country", name: "test text", location: "test location", type: "test type", iataCode: "test code", entityId: "test enitityid")
//        
//        let date = Date()
//        let expectedFlightResponse = FlightResponse(/* provide sample data here */)
//        mockRepository.flightResponse = expectedFlightResponse
//        
//        // Act
//        let result = mockRepository.getFlights(orgin: origin, destination: destination, date: date)
//        
//        // Assert
//        XCTAssertEqual(mockRepository.receivedGetFlightsParameters?.origin, origin)
//        XCTAssertEqual(mockRepository.receivedGetFlightsParameters?.destination, destination)
//        XCTAssertEqual(mockRepository.receivedGetFlightsParameters?.date, date)
//        XCTAssertEqual(result, expectedFlightResponse)
//        // Add more assertions based on your actual implementation
//    }

  

}
