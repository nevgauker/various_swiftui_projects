//
//  ContentView-ViewModel.swift
//  Bucketlist
//
//  Created by Rotem Nevgauker on 11/11/2023.
//

import MapKit
import LocalAuthentication

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        @Published  var showError = false

        var errorReason:String = ""

        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")

        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func addLocation() {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {success, authenticationError in
                    print(authenticationError?.localizedDescription ?? "")
                    if success {
                        Task { @MainActor in
                            self.isUnlocked = true
                        }
                    } else {
                        
                        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Enter your passcode") { success, authenticationError in
                            if success {
                                Task {
                                    self.isUnlocked = true
                                }
                            } else {
                                // Passcode authentication also failed
                                self.errorReason = authenticationError?.localizedDescription ?? ""
                                self.showError = true
                            }
                        }
                    }
                }
            } else {
                print(error?.localizedDescription   ??  "")
                errorReason = error?.localizedDescription  ??  ""
                showError = true
                // no biometrics
            }
        }
    }
}
