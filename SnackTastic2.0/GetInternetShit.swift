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
    var staticUrlOfImage : String = ""
    var startIndexOfInfo : [String] = [""]
    var endIndexOfInfo1 : String = ""
    var endIndexOfInfo2 : String = ""
    
    //Checkt, aus welchem Markt der Snack kommt
    func checkShop(url : String){
        if url.contains("real.de"){
            print("Real")
            //Start- und Endindex werden aus der Html erzeugt
        }
        else if url.contains("edeka.de"){
            print("Edeka")
            //Start- und Endindex werden aus der Html erzeugt
            startIndexOfImage = "<img style=\"display:none;\" src=\"//static.edeka.de/media/products/"
            endIndexOfImage = "\" id=\"productDetailImage"
            staticUrlOfImage = "https://static.edeka.de/media/products/"
            startIndexOfInfo = [
                "<table class=\"nutrition\">",
                "Brennwert in kJ\n</td><td class='col2'>",
                "Brennwert in kcal\n</td><td class='col2'>",
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
            print("Lidl")
            //Start- und Endindex werden aus der Html erzeugt
            startIndexOfImage = "data-image-index=\"0\">"
            endIndexOfImage = "\">"
            staticUrlOfImage = "https://www.lidl.de"
            startIndexOfInfo = [""]
            endIndexOfInfo1 = ""
        }
    }
    
    //Returned das IMAGE-URL
    func getImageUrl(imageURL : String ) -> String{
        checkShop(url : imageURL)
        //Hole kompletten HTML-Code als String
        let completeHTMLString = convertURLToHTML(value: imageURL)
        //Schneidet erste hälfte ab
        var myStringArr : [String] = completeHTMLString.components(separatedBy : startIndexOfImage)
        let first: String = myStringArr [1]
        //Schneidet zweite hälfte ab
        let second = first.components(separatedBy : endIndexOfImage)
        var variableUrl : String = second [0]
        //Kunstrgriff, wird noch in startIndex eingebracht
        if imageURL.contains("lidl.de"){
            let startIndex = "<a href=\""
            let endIndex = "\">"
            let myStringArr2 = myStringArr[1].components(separatedBy : startIndex)
            let second = myStringArr2 [1]
            let b = second.components(separatedBy : endIndex)
            variableUrl = b [0]
        }
        //Zusammensetzen
        let endUrl : String = staticUrlOfImage + variableUrl
        return endUrl
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
        checkShop(url : completeHTMLString)
        var infos : [String] = []
        var first = ""
        var second = [""]
        var myStringArr = [""]
        var i = 0
        for start in startIndexOfInfo{
            print("-------getInfoOfUrl-START------\(start)")
            var ende = ""
            print(ende)
            if(i == 0){
                ende = endIndexOfInfo1
                i = i + 1
            }else{
                ende = endIndexOfInfo2
            }
            //Schneidet bis Zur infoTabelle ab
            myStringArr = completeHTMLString.components(separatedBy : start)
            first = myStringArr [1]
            //Schneidet zweite hälfte ab
            second = first.components(separatedBy : ende)
            if(i == 0){
                break
            }else{
                infos += [second[0]]
            }
        }
        infos.remove(at: 0)
        return infos
    }

    
}
