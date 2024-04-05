//
//  CreateResult.swift
//  Travel
//
//  Created by Rotem Nevgauker on 11/01/2024.
//

import Foundation

struct FlightResponse: Codable {
    let sessionToken: String
    let status: String
    let action: String
    let content: Content
}

struct Content: Codable {
    let results: Results
    let stats: Stats
    let sortingOptions: SortingOptions
}

struct Results: Codable {
    let itineraries: [String: Itinerary]
    let legs: [String: Leg]
    let segments: [String: Segment]
    let places: [String: Place]
    let carriers: [String: Carrier]
    let agents: [String: Agent]
    let alliances: [String: Alliance]
}

struct Itinerary: Codable {
    let pricingOptions: [PricingOption]
    let legIds: [String]
    let sustainabilityData: SustainabilityData
}

struct PricingOption: Codable {
    let price: Price
    let agentIds: [String]
    let items: [Item]
    let transferType: String
    let id: String
    let pricingOptionFare: PricingOptionFare
}

struct Price: Codable {
    let amount: String
    let unit: String
    let updateStatus: String
}

struct Item: Codable {
    let price: Price
    let agentId: String
    let deepLink: String
    let fares: [String?]
}

struct PricingOptionFare: Codable {
    let cabinBaggage: Baggage
    let checkedBaggage: Baggage
    let legDetails: LegDetails
    let brandNames: [String]
}

struct Baggage: Codable {
    let assessment: String
    let pieces: Int
    let fee: Fee
    let weight: String
}

struct Fee: Codable {
    // You may need to define properties based on the actual structure of the "fee" object
}

struct LegDetails: Codable {
    let property1: Brand
    let property2: Brand
}

struct Brand: Codable {
    let brandNames: [String]
}

struct SustainabilityData: Codable {
    let isEcoContender: Bool
    let ecoContenderDelta: Int
}

struct Leg: Codable {
    // Define properties based on the actual structure of the "legs" object
}

struct Segment: Codable {
    // Define properties based on the actual structure of the "segments" object
}

struct Place: Codable {
    // Define properties based on the actual structure of the "places" object
}

struct Carrier: Codable {
    // Define properties based on the actual structure of the "carriers" object
}

struct Agent: Codable {
    // Define properties based on the actual structure of the "agents" object
}

struct Alliance: Codable {
    // Define properties based on the actual structure of the "alliances" object
}

struct Stats: Codable {
    let itineraries: ItineraryStats
}

struct ItineraryStats: Codable {
    let minDuration: Int
    let maxDuration: Int
    let total: TotalStats
    let stops: StopsStats
    let hasChangeAirportTransfer: Bool
}

struct TotalStats: Codable {
    let count: Int
    let minPrice: Price
}

struct StopsStats: Codable {
    let direct: StopTypeStats
    let oneStop: StopTypeStats
    let twoPlusStops: StopTypeStats
}

struct StopTypeStats: Codable {
    let total: TotalStats
    let ticketTypes: TicketTypeStats
}

struct TicketTypeStats: Codable {
    let singleTicket: TotalStats
    let multiTicketNonNpt: TotalStats
    let multiTicketNpt: TotalStats
}

struct SortingOptions: Codable {
    let best: [SortingOptionItem]
    let cheapest: [SortingOptionItem]
    let fastest: [SortingOptionItem]
}

struct SortingOptionItem: Codable {
    let score: Int
    let itineraryId: String
}

