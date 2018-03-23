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
import Firebase


class MathematicShit{
    
    //variablen, die auf die anderen Klassen referenzieren
    var showAll = SnackList()
    var showAllImages = SnackList()
    var getInternetShit = GetInternetShit()
    
    //funktion um Zufallszahl zu berechnen.
    func getRandomSnack(combinedSnackList: [String : String], sum : Int) -> (key : String, value : String) {
        //Check, ob liste leer ist
        if (combinedSnackList.isEmpty) {
            //Wenn ja dann,
            return ("Ups, da ist etwas schief gelaufen...😕", "")
        }else{
            //Ansonsten Zufallszahl generieren
            let randomNum: Int = Int(arc4random_uniform(UInt32(combinedSnackList.count)))
            //setzen des ZufallsSnacks
            let key : String = Array(combinedSnackList.keys)[randomNum]
            let value : String = combinedSnackList[key]!
            //ließ imageUrl aus HTML-Seite heraus -> später kann hier noch die weiteren Infos nachgetragen werden
            currentSnack = key
            let imageURL = getInternetShit.getImageUrl(imageURL : value)
            return (key, imageURL)
        }
    }
    
    //Setzt alle Listen zusammen
    func showAllSnacks()-> [String : String]{
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
        print("LOAD PERSISTENT DATA")
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
                    
                    if let url = result.value(forKey: "url") as? String {
                        print("url: " + url)
                    }
                    if let name = result.value(forKey: "name") as? String {
                        print("name: " + name)
                    }
                    if let kohlenhydrate = result.value(forKey: "kohlenhydrate") as? String {
                        print("kohlenhydrate: " + kohlenhydrate)
                        
                    }
                    if let image = result.value(forKey: "image") as? String {
                        print("image: " + image)
                        
                    }
                    if let fett = result.value(forKey: "fett") as? String {
                        print("fett: " + fett)
                        
                    }
                    if let davonZucker = result.value(forKey: "davonZucker") as? String {
                        print("davonZucker: " + davonZucker)
                        
                    }
                    if let brennwertInKJ = result.value(forKey: "brennwertInKJ") as? String {
                        print("brennwertInKJ: " + brennwertInKJ)
                        
                    }
                    if let brennwertInKcal = result.value(forKey: "brennwertInKcal") as? String {
                        print("brennwertInKcal: " + brennwertInKcal)
                        
                    }
                    if let ballaststoffe = result.value(forKey: "ballaststoffe") as? String {
                        print("ballaststoffe: " + ballaststoffe)
                        
                    }
                    if let eiweis = result.value(forKey: "eiweis") as? String {
                        print("eiweis: " + eiweis)
                        
                    }
                    if let salz = result.value(forKey: "salz") as? String {
                        print("salz: " + salz)
                        
                    }
                }
            }
        }
        catch {
            
        }
    }
    
    
    //Saves Data to Firebase
    func saveToDatabase(url: String, name: String, shop: String, genre: String, price: String, kohlenhydrate: String, fett: String, davonZucker: String, brennwertInKJ: String, brennwertInKcal: String, eiweis: String,
                        ballaststoffe : String, salz : String) -> Void {
        //let list = showAllItems()
        let context = getContext()
        
        // Allows new users to be saved INTO context (DataBase)
        let newSnack = NSEntityDescription.insertNewObject(forEntityName: "Snacks", into: context)
        
        // The way to set new values in entities in the DataBase
        newSnack.setValue(url, forKey: "url")
        newSnack.setValue(name, forKey: "name")
        //newSnack.setValue(iD, forKey: "iD")
        //newSnack.setValue(image, forKey: "image")
        newSnack.setValue(genre, forKey: "genre")
        newSnack.setValue(shop, forKey: "shop")
        newSnack.setValue(price, forKey: "price")
        newSnack.setValue(kohlenhydrate, forKey: "kohlenhydrate")
        newSnack.setValue(fett, forKey: "fett")
        newSnack.setValue(davonZucker, forKey: "davonZucker")
        newSnack.setValue(brennwertInKJ, forKey: "brennwertInKJ")
        newSnack.setValue(brennwertInKcal, forKey: "brennwertInKcal")
        newSnack.setValue(eiweis, forKey: "eiweis")
        newSnack.setValue(ballaststoffe, forKey: "ballaststoffe")
        newSnack.setValue(salz, forKey: "salz")
        
        // Trying to save the user
        do {
            try context.save()
            print(">> [SAVED] new Snack: " + url + " | " + name + " | " + " | "  + " |...")
            loadFromDatabase()
        }
        catch {
            // PROCESS ERROR
            print("SaveToDataBase failed...")
        }
        
    }
    
}
