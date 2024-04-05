//
//  ContentView.swift
//  Travel
//
//  Created by Rotem Nevgauker on 12/11/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()
    @State private var showSplash = true
    var body: some View {
            NavigationStack(path: $path){
                ZStack{
                    if  showSplash{
                        SplashScreen()
                            .transition(.opacity)
                    }else{
                        TravelForm(path: $path)
                            .navigationDestination(for: Response.self) { res in
                                ResultsView(respose:res)
                            }
                    }
                }
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        withAnimation{
                            self.showSplash = false
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
