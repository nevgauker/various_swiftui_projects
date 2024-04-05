//
//  DataController.swift
//  Bookworm
//
//  Created by Rotem Nevgauker on 04/11/2023.
//



import CoreData
import Foundation

class DataController: ObservableObject {
    let container =  NSPersistentContainer(name: "Bookworm")
    init(){
        container.loadPersistentStores(completionHandler: { description,error in
            if let err = error {
                print("CoreData failed to load:  \(err.localizedDescription)")
            }
        })
        
    }
    
}
