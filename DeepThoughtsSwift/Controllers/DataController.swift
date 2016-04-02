//
//  DataController.swift
//  DeepThoughtsSwift
//

import Foundation
import CoreData

class DataController {
    let managedObjectContext: NSManagedObjectContext
    
    init() {
        guard let modelURL = NSBundle.mainBundle().URLForResource("DataModel", withExtension: "momd") else {
            fatalError("Unable to find model file")
        }
        guard let model = NSManagedObjectModel(contentsOfURL: modelURL) else {
            fatalError("Failed to initilize data model")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
        managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
        
        Queue.Background.execute() {
            let filemanager = NSFileManager.defaultManager()
            let docURL = filemanager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last
            guard let storeURL = docURL?.URLByAppendingPathComponent("data.sqlite") else {
                fatalError("Unable to resolve store url")
            }
            do {
                try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
            } catch {
                fatalError("Failed \(error)")
            }
        }
    }
}