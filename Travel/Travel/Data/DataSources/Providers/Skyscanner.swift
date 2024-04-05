import Foundation

protocol AutoComplete {
    func autocompletePlaces(searchText: String) async throws -> [AutocompleteResult]
}

protocol Flights {
    func searchFlights(origin:AutocompleteResult,destination:AutocompleteResult) async throws -> FlightResponse?
}

//struct CreateResult {
//    let sessionToken:String
//}


struct PlaceId{
    let iata:String
    let entityId:String
}

struct  Skyscanner:AutoComplete,Flights {
    
    let apiKey:String
    
    
    
   // = "sh428739766321522266746152871799"
    let baseUrl :String
    //= "https://partners.api.skyscanner.net/apiservices/v3"
    let locale:String
    
    
    //= "en-US" // You can adjust the locale as needed
    let market :String
    
    
    
    //= "US"
    
    func searchFlights(origin:AutocompleteResult,destination:AutocompleteResult) async throws -> FlightResponse?{
        let flightsSearchEndpoint = "/flights/live/search/create"
        let components = URLComponents(string: baseUrl + flightsSearchEndpoint)
        guard let url = components?.url else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        var parameters: [String: [String: Any]] = [
            "query": [
                "locale": locale,
                "market" : market,
                "queryLeg" : [
                    "originPlaceId":[
                        "iata":  origin.iataCode,
                         "entityId":  origin.entityId
                    ],
                    "destinationPlaceId" : [
                            "iata":  destination.iataCode,
                            "entityId":  destination.entityId
                        ]
                ]
            ]
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        let (data, _) = try await URLSession.shared.data(for: request)
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                let placesData = try JSONSerialization.data(withJSONObject: json)
                let decoder = JSONDecoder()
                let results = try decoder.decode(FlightResponse.self, from: placesData)
                return results
        } catch {
            throw error
        }
    }
    
     func autocompletePlaces(searchText: String) async throws -> [AutocompleteResult] {
        let autocompleteEndpoint = "/autosuggest/flights"
         let components = URLComponents(string: baseUrl + autocompleteEndpoint)
        guard let url = components?.url else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        let parameters: [String: [String: String]] = [
            "query": [
                "locale": locale,
                "searchTerm": searchText,
                "market" : market
            ]
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        let (data, _) = try await URLSession.shared.data(for: request)
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            if let places = json?["places"] as? [[String: Any]] {
                print(places)
                let placesData = try JSONSerialization.data(withJSONObject: places)
                let decoder = JSONDecoder()
                let results = try decoder.decode([AutocompleteResult].self, from: placesData)
                return results
            } else {
                throw NSError(domain: "Invalid response format", code: 0, userInfo: nil)
            }
        } catch {
            throw error
        }
    }
}
