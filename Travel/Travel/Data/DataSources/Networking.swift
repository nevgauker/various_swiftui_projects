//
//  Networking.swift
//  Travel
//
//  Created by Rotem Nevgauker on 12/11/2023.
//

import Foundation


enum Providers{
    case skyscanner, kiwi
}

class Networking {
//    private  let serviceProvide:Skyscanner = Skyscanner(apiKey: "*****************", baseUrl: "https://partners.api.skyscanner.net/apiservices/v3", locale: "en-US", market: "US")
    
    
        private var selectedProvider:Providers = .skyscanner
        func changeProvider(provider:Providers){
            selectedProvider = provider
        }
    
    func autocompletePlaces(searchText: String) async ->[AutocompleteResult]?{
        do {
            let results:[AutocompleteResult]  = try await serviceProvide.autocompletePlaces(searchText: searchText)
            return results
        }
        catch{
            print(error.localizedDescription)
            return nil
        }
        
    }
    
    func searchFlights(origin: AutocompleteResult, destination:AutocompleteResult) async ->FlightResponse?{
        do {
            let response:FlightResponse = try await serviceProvide.searchFlights(origin: origin, destination: destination)!
            return response
        }
        catch{
            print(error.localizedDescription)
            return nil
        }
        
    }
}


class ChatGPT{
    
    static func getTravelSuggestions(origin :String, destination:String) async throws -> String {
        // Your API Key for ChatGPT API
//        let apiKey = ""
        
        // Define the API endpoint
        let endpoint = "https://api.openai.com/v1/engines/davinci/completions"
        
        // Define the parameters for the request
        let params: [String: Any] = [
            "prompt": "I am traveling between \(origin) and \(destination) and my schedule is flexible so im looking for recomdeations for 5 intersting places for longer layovers",
            "max_tokens": 100,
            "temperature": 0.5,
            "stop": ["\n"]
        ]
        
        let jsonData = try JSONSerialization.data(withJSONObject: params)
        
        var request = URLRequest(url: URL(string: endpoint)!)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let choices = json["choices"] as? [[String: Any]],
              let text = choices.first?["text"] as? String else {
            throw NSError(domain: "Parsing error", code: -1, userInfo: nil)
        }
        print(json)
        print(text)
        return text
    }
}
