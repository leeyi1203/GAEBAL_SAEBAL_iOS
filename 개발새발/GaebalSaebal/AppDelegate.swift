//
//  AppDelegate.swift
//  GaebalSaebal
//
//  Created by 이봄이 on 2022/04/06.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appHaveBeenRun {
            print("앱 설치 후 최초 실행시 실행됨")
            setupDefaultCategory()
        } nothingChanged: {
            print("변경사항 없음")
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "GaebalSaebal")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func appHaveBeenRun(firstrun: () -> (), nothingChanged: () -> ()) {
        let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        let versionOfLastRun = UserDefaults.standard.object(forKey: "VersionOfLastRun") as? String
        if versionOfLastRun == nil {
            // First start after installing the app
            firstrun()
        } else {
            // nothing changed
            nothingChanged()
        }
        UserDefaults.standard.set(currentVersion, forKey: "VersionOfLastRun")
        UserDefaults.standard.synchronize()
        
    }
    
    func setupDefaultCategory() {
        // save core data
        let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        let context = container.viewContext
        let defaultCategory = NSEntityDescription.entity(forEntityName: "Category", in: context)
        lazy var categoryList:[NSManagedObject] = {
            return CoreDataFunc.fetchCategoryList()
        }()
        
        CoreDataFunc.setupCategoryData(categoryList: categoryList)
        
        if let defaultCategory = defaultCategory {
            if categoryList.isEmpty {
                let start = NSManagedObject(entity: defaultCategory, insertInto: context)
                start.setValue("기본", forKey: "categoryName")
            }
        }

        do {
            try context.save()
            print("기본 카테고리 설정 완료")
        } catch {
            print("Error saving contet \(error)")
        }
    }

}

