//
//  FetchSuggestions.swift
//  Travel
//
//  Created by Rotem Nevgauker on 11/01/2024.
//

import Foundation



protocol FetchSuggestions {
    func getAutoCompleteSuggestions(searchText:String) async->[AutocompleteResult]?
}


struct FetchSuggestionsImpl :FetchSuggestions{
    let repository = FlightsRepositoryImpl()
    func getAutoCompleteSuggestions(searchText: String) async -> [AutocompleteResult]? {
        let suggestions =  await repository.getAutoCompleteSuggestions(searchText: searchText)
        return suggestions
    }
}
