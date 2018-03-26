//
//  GetInternetShit.swift
//  SnackTastic2.0
//
//  Created by Johannes Velde on 22.08.17.
//  Copyright © 2017 Johannes Velde. All rights reserved.
//
//  Datum       User        Action
//  17.08.17    Jo          Class added and conection to Internet established
//  23.08.17    Jo          Function getting now values of HTML-CODE

import Foundation

class GetInternetShit{
    
    var startIndexOfImage : String = ""
    var endIndexOfImage : String  = ""
    var staticImageURL : String = ""
    var startIndexOfInfo : [String] = [""]
    var endIndexOfInfo1 : String = ""
    var endIndexOfInfo2 : String = ""
    
    //Checkt, aus welchem Markt der Snack kommt und setzt Indexe, die zum extrahieren der Nährwerte wichtig ist.
    //Bis jetzt funktioniert nur Edeka
    func checkShop(url : String){
        if url.contains("real.de"){
            currentShop = "Real"
            print("Shop: Real")
        }
        else if url.contains("edeka.de"){
            currentShop = "Edeka"
            startIndexOfImage = "<img style=\"display:none;\" src=\"//static.edeka.de/media/products/"
            endIndexOfImage = "\" id=\"productDetailImage"
            staticImageURL = "https://static.edeka.de/media/products/"
            startIndexOfInfo = [
                "<table class=\"nutrition\">",
                "Brennwert in kJ\n</td><td class=\'col2\'>",
                "Brennwert in kcal\n</td><td class=\'col2\'>",
                "Fett in g\n</td><td class='col2'>",
                "Fett in g\n</td><td class='col2'>",
                "Fett, davon gesÃ¤ttigte FettsÃ¤uren in g\n</td><td class='col2'>",
                "Kohlenhydrate in g\n</td><td class='col2'>",
                "Kohlenhydrate, davon Zucker in g\n</td><td class=\'col2\'>",
                "<td class='col1'>EiweiÃ in g\n</td><td class='col2'>"
            ]
            endIndexOfInfo1 = "</table>"
            endIndexOfInfo2 = "\n</td><td class='col3'>"
        }
        else if url.contains("lidl.de"){
            currentShop = "Lidl"
            print("Shop: Lidl")
            //Start- und Endindex werden aus der Html erzeugt
            startIndexOfImage = "data-image-index=\"0\">"
            endIndexOfImage = "\">"
            staticImageURL = "https://www.lidl.de"
            startIndexOfInfo = [""]
            endIndexOfInfo1 = ""
        }
    }
    
    //Returned das IMAGE-URL
    func getImageUrl(imageURL : String ) -> String{
        //Setzt StartIndexe
        checkShop(url : imageURL)
        //Hole kompletten HTML-Code als String
        let completeHTMLString = convertURLToHTML(value: imageURL)
        //Schneidet erste (HTML)hälfte ab
        var firstPart : [String] = completeHTMLString.components(separatedBy : startIndexOfImage)
        let first: String = firstPart [1]
        //Schneidet zweite (HTML)hälfte ab
        let secondPart = first.components(separatedBy : endIndexOfImage)
        let variableImageURL : String = secondPart [0]
        //Zusammensetzen
        let currentImageURL = staticImageURL + variableImageURL
        return currentImageURL
    }
    
    //Bekomme aus Value(URL) den gesamten HTML-Code
    func convertURLToHTML(value : String) -> String {
        var completeHTMLString : String = ""
        //Überprüfung der URL, ob sie existiert
        guard let myURL = URL(string: value) else {
            return "Error: \(value) doesn't seem to be a valid URL"
        }
        do {
            //Holt sich gesamten HTML-CODE aus seite und vergleicht, ob der Snack in dem HTML beinhaltet ist.
            completeHTMLString = try String(contentsOf: myURL, encoding: .ascii)
        } catch let error {
            print("Error: \(error)")
        }
        return completeHTMLString
    }
    
    //Returned alle Nährwertangaben
    func getInfoOfUrl(completeHTMLString : String) -> [String]{
        var infos : [String] = []
        var first = ""
        var second = [""]
        var myStringArr = [""]
        var i = 0
        for start in startIndexOfInfo{
            var ende = ""
            if(i == 0){
                ende = endIndexOfInfo1
                i = i + 1
            }else{
                ende = endIndexOfInfo2
            }
            //Schneidet bis Zur infoTabelle ab
            myStringArr = completeHTMLString.components(separatedBy : start)
            //print(myStringArr[0])
            first = myStringArr [1]
            //Schneidet zweite hälfte ab
            second = first.components(separatedBy : ende)
            infos += [second[0]]
        }
        return infos
    }
    
    
}
