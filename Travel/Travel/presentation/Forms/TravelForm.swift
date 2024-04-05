//
//  TravelForm.swift
//  Travel
//
//  Created by Rotem Nevgauker on 12/11/2023.
//

import SwiftUI

struct TravelForm: View {
    
    @StateObject private var viewModel = ViewModel()
    @Binding var path: NavigationPath


    var body: some View {
            if viewModel.loadingState == .loaded{
                Form {
                    Section(header: Text("Travel Information")) {
                        TextFieldWithAutoComplete(text: "Origin ", suggestions: $viewModel.originSuggestions,selectedSuggestion: $viewModel.origin)
                        
                        TextFieldWithAutoComplete(text: "Layover", suggestions: $viewModel.layoverSuggestions, selectedSuggestion: $viewModel.layover)
                        
                        TextFieldWithAutoComplete(text: "Destination ", suggestions: $viewModel.destinationSuggestions,selectedSuggestion: $viewModel.destination)
                        Stepper(value: $viewModel.layoverRange, in: 1...10, label: {
                            Text("Layover Days: \(viewModel.layoverRange) " + (viewModel.layoverRange == 1 ? "day" : "days"))
                        })
                    }
                    Section(header:Text( "When")){
                        DatePicker("Date", selection: $viewModel.date, displayedComponents: [.date])
//                        RangeDatePicker(startDate: $viewModel.startDate, endDate: $viewModel.endDate)
                    }
                    
                    Section {
                        Button(action:  {
                            // Handle form submission
                            Task {
                                if let flights:[Flight] = await  viewModel.submitForm(){
                                    
                                    print("got respose")
                                }else{
                                    
                                }
                            }
                        }) {
                            Text("Search")
                        }
                    }
                }
                .navigationTitle("Travel Form")
            }else if viewModel.loadingState == .loading{
                VStack{
                    Spacer()
                    AnimatedLoader()
                    Spacer()

                }
            }else{
                Text("Some kind of error")
            }
    }
    
 
}

struct TravelForm_Previews: PreviewProvider {
    static var previews: some View {
        TravelForm(path: .constant(NavigationPath()))
    }
}
