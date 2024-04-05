import SwiftUI

struct TextFieldWithAutoComplete: View {
    let text:String
    let minLength = 2
    @State var location:String = ""
    @Binding var suggestions:[AutocompleteResult]?
    @Binding var selectedSuggestion:AutocompleteResult?

    @State var shouldAutoComplete = true


    let networking = Networking()
    var body: some View {
        VStack{
            TextField("\(text) ", text:$location)
                .onChange(of: location){
                    if (location.count >= minLength){
                        if shouldAutoComplete {
                            Task{
                                if let places =  await  networking.autocompletePlaces(searchText: location){
                                    suggestions = places
                                }
                            }
                        }else{
                            shouldAutoComplete = true
                        }
                    }
                }
            if let suggestions = suggestions {
                List {
                    ForEach(suggestions, id: \.self) { suggestion in
                        SuggestionRow(suggestion:suggestion)
                            .onTapGesture {
                                shouldAutoComplete = false
                                location  = suggestion.name ?? ""
                                selectedSuggestion = suggestion
                                self.suggestions = nil
                            }
                    }
                }
            }
        }
    }
    
}
