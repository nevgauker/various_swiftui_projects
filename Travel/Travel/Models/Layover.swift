import Foundation

struct Layover: Decodable,Hashable,Identifiable {
    var id:UUID = UUID()
    let location: String
    let days:Int
    // Add other properties as needed
}

