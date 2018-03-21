//
//  File.swift
//  SnackTastic
//
//  Created by Johannes Velde on 14/11/2016.
//  Copyright © 2016 Johannes Velde. All rights reserved.
//
//  Datum       Name    Action
//  11.08.17    Jo      readHTML und getImageUrl fertig und dokumentation erstellt

//Es wird von oben nach unten die Methoden in einer Reihe ausgeführt

import Foundation
import UIKit

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
            print("-----------doMathematicalShit-END----------")
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
    
}
