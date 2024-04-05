//
//  ContentView-ViewModel.swift
//  Travel
//
//  Created by Rotem Nevgauker on 12/11/2023.
//

import Foundation


extension TravelForm {
    @MainActor class ViewModel:ObservableObject {
        enum LoadingState {
            case loading, loaded, failed
        }
        
        @Published  var origin: AutocompleteResult?
        @Published  var destination: AutocompleteResult?
        @Published  var layover: AutocompleteResult?
        
        @Published  var originSuggestions:[AutocompleteResult]?
        @Published  var layoverSuggestions:[AutocompleteResult]?
        @Published  var destinationSuggestions:[AutocompleteResult]?
        
        @Published  var originText: String = ""
        @Published  var destinationText: String = ""
        @Published  var layoverText: String = ""
        
        @Published  var date = Date()
        
        let networking = Networking()
        //        @Published  var startDate = Date()
        //        @Published  var endDate = Calendar.current.date(byAdding: .day, value: 3, to: Date()) ?? Date()
        @Published  var layoverRange: Int = 1
        @Published  var loadingState = LoadingState.loaded
        
        
        
        func formattedDate(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            return dateFormatter.string(from: date)
        }
        
        
        func submitForm() async -> [Flight]?{
            guard  let o  = origin else {return nil }
            guard  let d  = destination else {return nil }
            guard  let l = layover else {return nil }
            let flights = await SeachFlightsImpl().seachFlights(orgin: o, layover: l, destination: d, date: date)
            return flights
        }
    }
}
 
