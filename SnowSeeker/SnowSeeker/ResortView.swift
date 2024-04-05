//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Rotem Nevgauker on 06/01/2024.
//

import SwiftUI

struct ResortView: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.dynamicTypeSize) var typeSize
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    @EnvironmentObject var favorites: Favorites

    let resort:Resort
    
    var body: some View {
        ScrollView{
            VStackLayout(alignment: .leading, spacing: 0){
                
                
                ZStack{
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Text(resort.imageCredit)
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(5)
                                .background(.black.opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .offset(x:-5,y:-5)
                        }
                    }
                   
                }
             
                HStack {
                    if sizeClass == .compact && typeSize > .large{
                        VStack(spacing: 10) { ResortDetailsView(resort: resort) }
                        VStack(spacing: 10) { SkiDetailsView(resort: resort) }
                    } else {
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(Color.primary.opacity(0.1))
                .padding(.vertical)
                .background(Color.primary.opacity(0.1))
                Group{
                    Text(resort.description)
                        .padding(.vertical)
                    Text("Facilities")
                        .font(.headline)
//                    HStack {
//                        ForEach(resort.facilityTypes) { facility in
//                            Button {
//                                selectedFacility = facility
//                                showingFacility = true
//                            } label: {
//                                facility.icon
//                                    .font(.title)
//                            }
//                        }
//                    }
//                    .padding(.vertical)
                    
                Text(resort.facilities, format: .list(type: .and))
                    .padding(.vertical)
                    
                    Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                        if favorites.contains(resort) {
                            favorites.remove(resort)
                        } else {
                            favorites.add(resort)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()

                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(selectedFacility?.name ?? "More information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
        } message: { facility in
            Text(facility.description)
        }
    }
}

#Preview {
    ResortView(resort: Resort.example)
        .environmentObject(Favorites())
}
