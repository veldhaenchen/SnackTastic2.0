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

class InfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    //Variables
    var math = MathematicShit()
    var getInternetShit = Internet()
    
    @IBOutlet weak var neahrwerteTableView: UITableView!

    let neahrwerte = [
        "Brennwert in KJ",
        "Brennwert in Kcal",
        "Fett",
        "Davon Gesättigte Fettsäuren",
        "Kohlenhydrate",
        "Davon Zucker",
        "Einweiß",
        "Salz"
    ]
    var share : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initialize TableView
        neahrwerteTableView.delegate = self
        neahrwerteTableView.dataSource = self
        print("Anfang Nährwerte von \(currentSnack):\n Anfang der Infos: \(currentInfos)")
        // Do any additional setup after loading the view.
        //loopt durch die komplette liste und findet den KEY
        if let url = math.showAllSnacks().first(where: { (key, _) in key.contains(currentSnack) }) {
            print("URL von Snack: \(url.value)")
            //Hole erst HTML-String
            let fullHTML : String = getInternetShit.extractToHTML(value: url.value)
            //Und danach Info Aus Nährwertangaben
            let infos = getInternetShit.getInfoOfUrl(fullHTML : fullHTML)
            currentInfos.remove(at: 0)
            currentInfos.remove(at: 0)
            print("\(currentInfos) \n")
            share = currentInfos
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return neahrwerte.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = neahrwerteTableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = neahrwerte[indexPath.row]
        cell?.detailTextLabel?.text = share[indexPath.row]
        
        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
