//
//  InfoViewController.swift
//  SnackTastic2.0
//
//  Created by Johannes Velde on 22.08.17.
//  Copyright © 2017 Johannes Velde. All rights reserved.
//
//  Datum       Name    Action
//  24.08.17    Jo      Class added and Values placed -> Working
//  27.08.17    Jo      BUG: CellViews müssen wieder aufgelöst werden und zu stack views zusammen geführt werden
//  22.03.2018  Jo      Anfang von CoreData

import Foundation
import UIKit

class InfoViewController: UIViewController{
        
    var math = MathematicShit()
    var getInternetShit = GetInternetShit()
    var views = ViewController()
    var resultText = String()

   
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var label8: UILabel!
    @IBOutlet weak var label9: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Anfang Nährwerte von \(currentSnack):")
        // Do any additional setup after loading the view.
        
        //loopt durch die komplette liste und findet den KEY
        if let url = math.showAllSnacks().first(where: { (key, _) in key.contains(currentSnack) }) {
            print("URL von Snack: \(url.value)")
            //Hole erst HTML-String
            let completeHTMLString : String = getInternetShit.convertURLToHTML(value: url.value)
            //Und danach Info Aus Nährwertangaben
            let infos : [String] = getInternetShit.getInfoOfUrl(completeHTMLString : completeHTMLString)
            label1.text = infos[8]
            label2.text = infos[1]
            label3.text = infos[2]
            label4.text = infos[3]
            label5.text = infos[4]
            label6.text = infos[5]
            //Ballaststoffe gibt es leider bei trinken nicht
            label7.text = "NULL"
            label8.text = infos[6]
            label9.text = infos[7]
        } else {
            label1.text = "NULL"
            label2.text = "NULL"
            label3.text = "NULL"
            label4.text = "NULL"
            label5.text = "NULL"
            label6.text = "NULL"
            label7.text = "NULL"
            label8.text = "NULL"
            label9.text = "NULL"
        }
        
        
        
    }
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
