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
    var getInternetShit = Internet()
    
    //funktion um Zufallszahl zu berechnen.
    func getRandomSnack(combinedSnackList: [String : String]) -> (key : String, value : String) {
        //Check, ob liste leer ist
        if (combinedSnackList.isEmpty) {
            //Wenn ja dann,
            return ("Ups, da ist etwas schief gelaufen...😰🍕❌", "")
        }else{
            //Ansonsten Zufallszahl generieren
            let randomNum: Int = Int(arc4random_uniform(UInt32(combinedSnackList.count)))
            //setzen des ZufallsSnacks
            let key : String = Array(combinedSnackList.keys)[randomNum]
            let value : String = combinedSnackList[key]!
            //ließ imageUrl aus HTML-Seite heraus
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
        print("LOAD PERSISTENT DATA FOR \(currentSnack)")
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
                for data in results as! [NSManagedObject] {
                    count += 1// COUNT++
                    
                    if currentSnack == data.value(forKey: "name") as? String {
                        //Laden der Datenbank in die Zwischenablage
                        currentMainURL = data.value(forKey: "url") as! String
                        currentImageURL = data.value(forKey: "imageUrl") as! String
                        currentNaehrwerte[0] = data.value(forKey: "salt") as! String
                        
                        //Console output
                        print("name: " + currentSnack)
                        print("url: " + currentMainURL)
                        print("imageUrl: " + currentImageURL)
                        print("Shop: " + currentShop)
                        print("Genre: " + currentGenre)
                        print("salt: " + currentNaehrwerte[0])
                        
                    }
                }
            }
        }
        catch {
        }
    }
    
    
    //Saves Data to CoreData
    func saveToDatabase(url: String,imageUrl: String, name: String, shop: String, genre: String, price: String, kohlenhydrate: String, fett: String, davonZucker: String, brennwertInKJ: String, brennwertInKcal: String, eiweis: String,
                        ballaststoffe : String, salt : String) -> Void {
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
        newSnack.setValue(imageUrl, forKey: "imageUrl")
        newSnack.setValue(shop, forKey: "shop")
        newSnack.setValue(price, forKey: "price")
        newSnack.setValue(kohlenhydrate, forKey: "kohlenhydrate")
        newSnack.setValue(fett, forKey: "fett")
        newSnack.setValue(davonZucker, forKey: "davonZucker")
        newSnack.setValue(brennwertInKJ, forKey: "brennwertInKJ")
        newSnack.setValue(brennwertInKcal, forKey: "brennwertInKcal")
        newSnack.setValue(eiweis, forKey: "eiweis")
        newSnack.setValue(ballaststoffe, forKey: "ballaststoffe")
        newSnack.setValue(salt, forKey: "salt")
        
        // Trying to save the snack
        do {
            try context.save()
            print(">> [SAVED] new Snack: " + name + "\n")
        }
        catch {
            // PROCESS ERROR
            print("SaveToDataBase failed...")
        }
        
    }
    
}
