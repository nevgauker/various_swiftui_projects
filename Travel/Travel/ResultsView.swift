import SwiftUI

struct ResultsView: View {
    let respose:Response
    var body: some View {
        List(respose.journeys, id: \.self) { journey in
            VStack(alignment: .leading,spacing: 3) {        
                Text(journey.name)
                    .font(.title)
                Text("From:  \(journey.originCountry)  \(journey.originAirport)")
                    .font(.subheadline)
                Divider()
                VStack{
                    ForEach(journey.layovers) { layover in
                        HStack{
                            Text("\(layover.location) - \(layover.days)")
                                .padding()
                            Image(systemName: "airplane.arrival")
                            Image(systemName: "airplane.departure")

                        }
                        }
                          
                }
                Divider()
                Text("To:  \(journey.destinationCountry)  \(journey.destinationAirport)")
                    .font(.subheadline)
                Text("\(journey.date) - \(journey.time)")
                Divider()
                HStack{
                    Text("$\(journey.price)")
                        .font(.title)
                        .fontWeight(.bold)
                    Button("Get Now"){
                        
                    }
                }
               
            }
        }
    }
}

#Preview {
    ResultsView(respose: Response(id: UUID(), journeys: fakeData))
        .navigationTitle("Results")
}
