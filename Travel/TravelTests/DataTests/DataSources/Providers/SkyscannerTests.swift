//
//  SkyscannerTests.swift
//  TravelTests
//
//  Created by Rotem Nevgauker on 11/01/2024.
//
@testable import Travel
import XCTest


class SkyscannerTests: XCTestCase {
    
    let mockApiKey = "mockApiKey"
    let mockBaseUrl = "mockUrl"
    let mockLocale = "en-US"
    let mockMarket = "US"
    
    // Mock Autocomplete Result
    
    let mockOrigin = AutocompleteResult(cityName: "test", countryName: "test", name: "test", location: "test", type: "test", iataCode: "test", entityId: "test")

    let mockDestination = AutocompleteResult(cityName: "test", countryName: "test", name: "test", location: "test", type:"test", iataCode: "test", entityId: "test")
    
    
    func testSearchFlights() async throws {
        
        //mock api key = error
        let skyscanner = Skyscanner(apiKey: mockApiKey, baseUrl: mockBaseUrl, locale: mockLocale, market: mockMarket)
        do {
            let flightResponse = try await skyscanner.searchFlights(origin: mockOrigin, destination: mockDestination)
            XCTFail("no response with mock api key")
        } catch {
            //mock api key = always error
            XCTAssertTrue(true)
        }
    }
    
    func testAutocompletePlaces() async throws {
        let skyscanner = Skyscanner(apiKey: mockApiKey, baseUrl: mockBaseUrl, locale: mockLocale, market: mockMarket)
        
        do {
            _ = try await skyscanner.autocompletePlaces(searchText: "New York")
          XCTFail("no response with mock api key")
        } catch {
            //mock api key = always error
            XCTAssertTrue(true)
        }
    }
     
    //TBD ADD SOME TESTS WITH REAL API KEY
}

