//
//  Prospect.swift
//  HotProspects
//
//  Created by Rotem Nevgauker on 26/11/2023.
//

import SwiftUI


class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var createdAt:Date = .now
    fileprivate(set) var isContacted = false
    
    
    
    func getDate(daysAgo: Int) -> Date {
        let calendar = Calendar.current
        let currentDate = Date()
        if let pastDate = calendar.date(byAdding: .day, value: -daysAgo, to: currentDate) {
            return pastDate
        } else {
            // Handle error or default case
            return currentDate
        }
    }
    
    init(name:String,emailAddress:String){
        self.name = name
        self.emailAddress = emailAddress
    }
}

@MainActor class Prospects: ObservableObject {
    @Published var people: [Prospect]
    //let saveKey = "SavedData"
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPeople")

    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
//    private func save() {
//        if let encoded = try? JSONEncoder().encode(people) {
//            UserDefaults.standard.set(encoded, forKey: saveKey)
//        }
//    }
    
    init() {
        
        if let data = try? Data(contentsOf: savePath){
        
      //  if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decoded
                return
            }
        }
        people = []
    }
}
