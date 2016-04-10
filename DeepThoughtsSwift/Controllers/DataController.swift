//
//  DataController.swift
//  DeepThoughtsSwift
//

import Foundation
import CoreData

class DataController {
    let managedObjectContext: NSManagedObjectContext
    
    init() {
        guard let modelURL = NSBundle.mainBundle().URLForResource("DeepThoughtsCoreData", withExtension: "momd") else {
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
                fatalError("Failed: \(error)")
            }
        }
    }

    private func save() {
        if !NSThread.isMainThread() {
            Queue.Main.execute() {
                self.save()
            }
            return
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Saved failed: \(error)")
        }
    }

    func getAllThoughts(closure: ([AnyObject]) -> ()) {
        let nc = NetworkController()
        nc.getAllThoughts() { json in
            //TODO: Server needs to return the correct data.            
            
            let request = NSFetchRequest(entityName: "Thought")
            let result = try! self.managedObjectContext.executeFetchRequest(request)
            
            closure(result)
        }
    }

    
    
    
    
    
    
    func testFakeData() {
        if let dataPath = NSBundle.mainBundle().pathForResource("fakeData", ofType: "json") {
            let rawData = NSData(contentsOfFile: dataPath)

            do {
                let json = try NSJSONSerialization.JSONObjectWithData(rawData!, options: .AllowFragments)
                print("Json is \(json)")
            } catch {
                print("Error is \(error)")
            }
        }
    }

    func testSaveAndRetrieve() {
        let entityThought = NSEntityDescription.entityForName("Thought", inManagedObjectContext: managedObjectContext)
        let testThought = NSManagedObject(entity: entityThought!, insertIntoManagedObjectContext: managedObjectContext)
        
        testThought.setValue("This is the test title2", forKey: "title")
        
        let entityCategory = NSEntityDescription.entityForName("Category", inManagedObjectContext: managedObjectContext)
        let testCategory = NSManagedObject(entity: entityCategory!, insertIntoManagedObjectContext: managedObjectContext)
        
        testCategory.setValue("This is test category2", forKey: "name")
        
        testThought.setValue(testCategory, forKey: "category")
        
        self.save()
        
        // Fetch
        let fetchRequest = NSFetchRequest(entityName: "Thought")
        
        do {
            let result = try managedObjectContext.executeFetchRequest(fetchRequest)
            
            for item in result {
                if let title = item.valueForKey("title") {
                    print("Title is \(title)")
                }
                if let category = item.valueForKey("category") {
                    print("Category is \(category.valueForKey("name"))")
                }
            }
        } catch {
            print("Failed")
        }
    }
}
