//
//  SnackLists.swift
//  SnackTastic
//
//  Created by Johannes Velde on 14/11/2016.
//  Copyright © 2016 Johannes Velde. All rights reserved.
//
//  Datum       Name    Action
//  12.08.17    Jo      Dictionary created, KEY LETTER LIKE ÖÄÜ HAVE TO BE AEUEOU


import Foundation
import UIKit

class SnackList{
    
    //Snacklist
    let getraenkeList : [String : String] = [
        //EDEKA
        "Ice Tea Wildkirsche" : "https://www.edeka.de/de/produkte/edeka-ice-tea-wildkirsche-dpg",
        "Ice Tea Pfirsich" : "https://www.edeka.de/de/produkte/ice-tea-pfirsich"
        //LIDL
    ]
    
    let schokoladeList : [String : String] = [
        //EDEKA
        "Edel-Zartbitter Orange Noir" : "https://www.edeka.de/de/produkte/edeka-edel-zartbitter-72-mit-orange-100g",
        //LIDL
        "Ferrero hanuta" : "https://www.lidl.de/de/ferrero-hanuta/p205988",
        //"Manner Neapolitaner Schnitten" : "https://www.lidl.de/de/manner-neapolitaner-schnitten-4er/p250391",
        "Nestlé KitKat Classic" : "https://www.lidl.de/de/nestle-kitkat-classic-5er/p233150",
        "Celebrations" : "https://www.lidl.de/de/celebrations/p238169",
        "Cerealienriegel Schoko Cornflakes" : "https://www.lidl.de/de/crownfield-cerealienriegel-schoko-cornflakes/p233184",
        "Prinzenrolle" : "https://www.lidl.de/de/debeukelaer-prinzenrolle/p205981"
    ]
    
    let chipsList : [String : String] = [
        //EDEKA
        "Chips-Cracker Sour Cream & Onion" : "https://www.edeka.de/de/produkte/edeka-chips-cracker-sour-cream-onion-125g",
        "Bacon-Snack" : "https://www.edeka.de/de/produkte/gut-guenstig-bacon-snack-130g",
        "Gourmet-Chips Paprika" : "https://www.edeka.de/de/produkte/edeka-gourmet-chips-bola-paprika-125g",
        "Gourmet-Chips Pfeffer & Salz" : "https://www.edeka.de/de/produkte/edeka-gourmet-chips-meersalz-tellicherry-pfeffer-125g",
        "Tortilla-Chips Hot Chili" : "https://www.edeka.de/de/produkte/edeka-tortillachips-chili-300g",
        "Tortilla-Chips Nacho Cheese" : "https://www.edeka.de/de/produkte/edeka-tortillachips-nacho-cheese-300g",
        "Tortilla-Chips Natural Salted" : "https://www.edeka.de/de/produkte/edeka-tortillachips-gesalzen-300g",
        "Tortilla milde Paprika" : "https://www.edeka.de/de/produkte/edeka-tortillachips-paprika-300g",
        //LIDL
        "Lorenz Erdnusslocken Classic" : "https://www.lidl.de/de/lorenz-erdnusslocken-classic/p205935",
        "CRUSTI CROC Mini Brotchips Knoblauch" : "https://www.lidl.de/de/crusti-croc-mini-brotchips-knoblauch/p233177",
        "CRUSTI CROC Mini Brotchips Zwiebel" : "https://www.lidl.de/de/crusti-croc-mini-brotchips-zwiebel/p233178",
        "CRUSTI CROC Mini Brotchips Sauerrahm-Zwiebel" : "https://www.lidl.de/de/crusti-croc-mini-brotchips-sauerrahm-zwiebel/p248468",
        "POM-BÄR Original" : "https://www.lidl.de/de/pom-baer-original/p252683",
        "Pringles Sour Cream & Onion" : "https://www.lidl.de/de/pringles-sour-cream-onion/p205951",
        "Pringles Hot & Spicy" : "https://www.lidl.de/de/pringles-hot-spicy/p206551",
        "Kessel-Chips Salt & Vinegar" : "https://www.lidl.de/de/funny-frisch-kessel-chips-salt-vinegar/p246749"
    ]
    
    let fruchtgummiList : [String : String] = [
        //EDEKA
        "Frucht Mix" : "https://www.edeka.de/de/produkte/gut-guenstig-frucht-mix-300g-1",
        //LIDL
        "Haribo Color-Rado" : "https://www.lidl.de/de/haribo-color-rado/p205945",
        "SUGAR LAND Apfelringe" : "https://www.lidl.de/de/sugar-land-apfelringe/p213990",
        "Trolli Spaghettini Sour Apfel" : "https://www.lidl.de/de/trolli-spaghettini-sour-apfel/p250000"
    ]
    
    let gebaeckList : [String : String] = [
        //EDEKA
        "Chocolate Cream Cookies" : "https://www.edeka.de/de/produkte/edeka-chocolate-cream-cookies-mit-fluessigem-schokoladenkern-210g",
        "Double Chocolate Cookies" : "https://www.edeka.de/de/produkte/edeka-cookies-double-chocolate-200g",
        "Triple Chocolate Cookies" : "https://www.edeka.de/de/produkte/edeka-cookies-triple-chocolate-200g",
        "Dark Chocolate & Hazelnut Cookies" : "https://www.edeka.de/de/produkte/edeka-cookies-dark-chocolate-hazelnut-200g",
        "Cookies & Cream" : "https://www.edeka.de/de/produkte/gut-guenstig-cookies-n-cream-176g",
        //LIDL
        "CRUSTI CROC Erdnussflips" : "https://www.lidl.de/de/crusti-croc-erdnussflips/p192386"
    ]
    
    let sonstigesList : [String : String] = [
        //EDEKA
        "Asia Nuts" : "https://www.edeka.de/de/produkte/edeka-asia-nuts-wasabi-style-wuerzig-scharf-150g",
        "Erdnuss-Cashew-Mix Chili" : "https://www.edeka.de/de/produkte/edeka-erdnuss-cashew-mix-mit-chili-175g",
        "Studentenfutter Premium" : "https://www.edeka.de/de/produkte/edeka-studentenfutter-premium-200g",
        "Studentenfutter, klassische Mischung" : "https://www.edeka.de/de/produkte/edeka-studentenfutter-klassische-mischung-200g",
        //LIDL
        "Fruchtgenussbonbons" : "https://www.lidl.de/de/amanie-fruchtgenussbonbons/p213622",
        "Fruchtkaubonbons" : "https://www.lidl.de/de/sugar-land-fruchtkaubonbons/p192378"
    ]
}
