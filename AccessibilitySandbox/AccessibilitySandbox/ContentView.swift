//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Rotem Nevgauker on 26/11/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var value = 10
    var body: some View {
        VStack {
            Text("Value: \(value)")
            Button("+++++"){
                value+=1
            }
            Button("------"){
                value-=1
            }
        }
        
        .accessibilityElement()
        .accessibilityLabel("Value")
        .accessibilityValue(String(value))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                value+=1
            case .decrement:
                value-=1
            default:
                print("no handled.")
            }
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
