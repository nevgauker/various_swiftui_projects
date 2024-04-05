import Foundation

struct Journey: Decodable,Hashable {
    var id:UUID = UUID()
    let name:String
    let originCountry: String
    let destinationCountry: String
    let originAirport: String
    let destinationAirport: String
    let flightDate:Date
    let price:Int
    let layovers:[Layover]

    var date:String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: flightDate)
    }
    var time:String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: flightDate)
    }
    
}



let fakeData:[Journey] =  [
    Journey(name: "Flight from athens to berlin", 
            originCountry: "Greece, Athens",
            destinationCountry: "Berlin, Germany",
            originAirport: "ATH", destinationAirport: "BRE",
            flightDate: .now,
            price: 99,
            layovers: [
                Layover(location: "Paris", days: 2),
                Layover(location: "London", days: 4)
            ]
           )
]
