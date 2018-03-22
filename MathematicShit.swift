//
//  File.swift
//  SnackTastic
//
//  Created by Johannes Velde on 14/11/2016.
//  Copyright © 2016 Johannes Velde. All rights reserved.
//
//  Datum       Name    Action
//  11.08.17    Jo      readHTML und getImageUrl fertig und dokumentation erstellt
//  22.03.18    Jo      CoreData inserted
//Es wird von oben nach unten die Methoden in einer Reihe ausgeführt

import Foundation
import UIKit
import CoreData

class MathematicShit{
    //variablen, die auf die anderen Klassen referenzieren
    var showAll = SnackList()
    var showAllImages = SnackList()
    var getInternetShit = GetInternetShit()
    
    //funktion um Zufallszahl zu berechnen.
    func doMathematicalShit(combine: [String : String], sum : Int) -> (key : String, value : String) {
        //Check, ob liste leer ist
        if (combine.isEmpty) {
            //Wenn ja dann,
            return ("Ups, da ist etwas schief gelaufen...😕", "")
        }else{
            //Ansonsten Zufallszahl generieren
            let index: Int = Int(arc4random_uniform(UInt32(combine.count)))
            //setzen des ZufallsSnacks
            let key : String = Array(combine.keys)[index]
            let value : String = combine[key]!
            //ließ imageUrl aus HTML-Seite heraus -> später kann hier noch die weiteren Infos nachgetragen werden
            publicSnackVar = key
            print(publicSnackVar)
            let imageUrl = getInternetShit.getImageUrl(imageURL : value)
            print("ImageUrl:\t \(imageUrl) \n Snack: \t \(key)")
            return (key, imageUrl)
        }
    }
    
    //Setzt alle Listen zusammen
    func showAllItems()-> [String : String]{
        var combine : [String : String] = [:]
        showAll.chipsList.forEach { (k,v) in combine[k] = v }
        showAll.schokoladeList.forEach { (k,v) in combine[k] = v }
        showAll.fruchtgummiList.forEach { (k,v) in combine[k] = v }
        showAll.gebaeckList.forEach { (k,v) in combine[k] = v }
        showAll.getraenkeList.forEach { (k,v) in combine[k] = v }
        showAll.sonstigesList.forEach { (k,v) in combine[k] = v }
        return combine
    }
    
    //CoreData
    // Gives you the persistent container in which everything is stored
    func getContext() -> NSManagedObjectContext {
        // Access AppDelegate (where core data is linked to)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // Access the database within AppDelegate (Core Data)
        return appDelegate.persistentContainer.viewContext
    }
    
    // Loading DataBase into the entity - lists
    func loadFromDatabase() -> Void {
        // Get context
        let context = getContext()
        
        // Request to access data from the DataBase
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Snacks")
        request.returnsObjectsAsFaults = false
        
        // Try to access the DataBase with the request
        do {
            let results = try context.fetch(request)
            var count = 0 // Counts the amount of snacks
            
            // Prints every result from all results
            if results.count > 0 {
                
                // Go through every object
                for result in results as! [NSManagedObject] {
                    count += 1// COUNT++
                    
                    // If url is a String:
                    if let url = result.value(forKey: "url") as? String {
                        print("PERSISTENT MOTHERFUCKER!!!")
                        print(url)
                    }
                    if let name = result.value(forKey: "name") as? String {
                    }
                    if let kohlenhydrate = result.value(forKey: "kohlenhydrate") as? String {
                    }
                    if let image = result.value(forKey: "image") as? String {
                    }
                    if let fett = result.value(forKey: "fett") as? String {
                    }
                    if let davonZucker = result.value(forKey: "davonZucker") as? String {
                    }
                    if let brennwertInKJ = result.value(forKey: "brennwertInKJ") as? String {
                    }
                    if let brennwertInKcal = result.value(forKey: "brennwertInKcal") as? String {
                    }
                    if let ballaststoffe = result.value(forKey: "ballaststoffe") as? String {
                    }
                    if let eiweis = result.value(forKey: "eiweis") as? String {
                    }
                    if let salz = result.value(forKey: "salz") as? String {
                    }
                }
            }
        }
        catch {
            
        }
    }
    
    func saveToDatabase(url : String, name : String) -> Void {
        //let list = showAllItems()
        let context = getContext()
        
        // Allows new users to be saved INTO context (DataBase)
        let newSnack = NSEntityDescription.insertNewObject(forEntityName: "Snacks", into: context)
        
        // The way to set new values in entities in the DataBase
        newSnack.setValue(url, forKey: "url")
        newSnack.setValue(name, forKey: "name")
        // Trying to save the user
        do {
            try context.save()
            print(">> [SAVED] new Snack: " + url + " | " + name + "...")
            loadFromDatabase()
        }
        catch {
            // PROCESS ERROR
            print("SaveToDataBase failed...")
        }
    }
    
}
