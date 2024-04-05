import Foundation

struct Response: Decodable,Hashable {
    var id:UUID = UUID()
    let journeys:[Journey]
}
