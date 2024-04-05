import SwiftUI


struct AdviceScreen: View{
    @State  var text:String = ""
    
    @State private var origin:String = ""
    @State private var destination:String = ""
    @State private var output:String = ""
    @State  var originSuggestions:[AutocompleteResult]?
    @State  var destinationSuggestions:[AutocompleteResult]?

    var body: some View {
        VStack{
            HStack{
                Image(systemName: "brain.head.profile")
                Spacer()
            }
//            TextFieldWithAutoComplete(text: "Origin ", location: $origin, suggestions: $originSuggestions)
//            TextFieldWithAutoComplete(text: "Destination ", location: $destination, suggestions: $destinationSuggestions)
            Button("Send"){
                Task{
                    do {
                        let opt = try await ChatGPT.getTravelSuggestions(origin: origin, destination: destination)
                        self.output = opt
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
            Divider()
            Text(output)
                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0)))
               

           
            Spacer()
        }
        .padding()
    }
    
}

#Preview {
    AdviceScreen(text: "Sdvsdfvds")
}

