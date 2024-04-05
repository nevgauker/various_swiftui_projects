import SwiftUI


struct SuggestionRow: View {
    
    let suggestion:AutocompleteResult
    var body: some View {
        VStack{
            HStack{
                Text(suggestion.name ?? "no name")
                    .font(.headline)
                Spacer()
                Image(suggestion.iconName)
                    .frame(width: 50, height: 50)
            }
            HStack{
                Text("\(suggestion.cityName ?? "no city"), \(suggestion.countryName  ?? "no country")")  .font(.subheadline)
                Spacer()
            }
        }
    }
}
