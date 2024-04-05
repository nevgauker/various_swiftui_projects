//
//  SeatchFlights.swift
//  Travel
//
//  Created by Rotem Nevgauker on 11/01/2024.
//

import Foundation

protocol SeachFlights{
    func seachFlights(orgin:AutocompleteResult,layover:AutocompleteResult,destination:AutocompleteResult,date:Date) async ->[Flight]?
}

struct SeachFlightsImpl:SeachFlights{
    let repository = FlightsRepositoryImpl()

    func seachFlights(orgin: AutocompleteResult, layover: AutocompleteResult, destination: AutocompleteResult, date: Date) async -> [Flight]? {
        let respose  = await repository.getFlights(orgin: orgin, destination: destination, date: date)
        //TBD FlightResponse -> [Flights]
        let flights:[Flight] = []
        return flights
    }
}
