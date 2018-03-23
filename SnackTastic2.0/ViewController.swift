//
//  ViewController.swift
//  SnackTastic
//
//  Created by Johannes Velde on 12/04/2017.
//  Copyright © 2017 Johannes Velde. All rights reserved.
//
//  Datum       Name    Action
//  12.04.17    Jo      Recoded and Console output for Debugging added
//  16.04.17    Jo      Music Player added
//  25.04.17    Jo      Music Player configured and ready to run
//  17.06.17    Jo      Trying to get colorChange function of buttons
//  31.07.17    Jo      ColorChangeFunction now working
//  01.08.17    Jo      Animation works but should be more easier to solve! (2d array and 2 loops)
//  12.08.17    Jo      Added a Function in vewdidLoad to avoid url Errors
//  24.08.17    Jo      Documentation written
//  23.03.18    Jo      Added First Initializng, which can be seen by clicking start
//  23.03.18    Jo      Removed shoppingCartButton and added RefreshButton with function
import UIKit
import AVFoundation //Für Musik


//Öffentliche SnackVariable, die den gerade gezogenen Snack beinhaltet
public var currentSnack = "ERROR"

class ViewController: UIViewController {
    //Inititalisiere Variablen
    var snacklist = SnackList()
    var math = MathematicShit()
    var getInternetShit = GetInternetShit()
    
    //Ausgabe, Buttons und so weiter
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sound: UIButton!
    @IBOutlet weak var chips: UIButton!
    @IBOutlet weak var fruchtgummi: UIButton!
    @IBOutlet weak var schokolade: UIButton!
    @IBOutlet weak var gebaeck: UIButton!
    @IBOutlet weak var trinken: UIButton!
    @IBOutlet weak var sonstiges: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    weak var shapeLayer: CAShapeLayer?
    
    
    //---------------Music Definition-START----------//
    //var für player
    var audioPlayer = AVAudioPlayer()
    //Das hier setzt den „Pfad“ wo die musik herkommt
    @IBAction func playMusic(_ sender: UIButton) {
        if(audioPlayer.isPlaying){
            sender.setBackgroundImage( #imageLiteral(resourceName: "NoMusic.png"), for: UIControlState.normal)
            audioPlayer.stop()
        }else{
            sender.setBackgroundImage( #imageLiteral(resourceName: "MaxVolume.png"), for: UIControlState.normal)
            audioPlayer.play()
        }
    }
    //---------------Music Definition-ENDE----------//
    
    //---------------Refresh DataBase-START---------//
    @IBAction func refreshButton(_ sender: UIButton) {
        //First Intitializing
        for (key, value) in math.showAllSnacks() {
            //Animation Rotation
            let imgViewRing = UIImageView(image: UIImage(named: "refresh"))
            imgViewRing.frame = CGRect(x: 0, y: 0, width: UIImage(named: "refresh")!.size.width, height: UIImage(named: "refresh")!.size.height)
            imgViewRing.center = CGPoint(x: self.view.frame.size.width/2.0, y: self.view.frame.size.height/2.0)
            rotateAnimation(imageView: imgViewRing)
            self.view.addSubview(imgViewRing)
            
            print("name:" + key + "\n" + "url: " + value)
            
            var imageURL = getInternetShit.getImageUrl(imageURL : value)
            print("ImageURL: " + imageURL)
            var htmlString = getInternetShit.convertURLToHTML(value: value)
            var info = getInternetShit.getInfoOfUrl(completeHTMLString : htmlString)
            /*
             print(
             "Brennwert in kJ: \t\t\t\t\t\(info[0])\n" +
             "Brennwert in kcal: \t\t\t\t\t\(info[1])\n" +
             "Fett in g: \t\t\t\t\t\t\t\(info[2])\n" +
             "Davon gesättigte Fettsäuren in g: \t\(info[3])\n" +
             "Kohlenhydrate in g: \t\t\t\t\(info[4])\n" +
             "davon Zucker in g: \t\t\t\t\t\(info[5])\n" +
             //"Ballaststoffe in g: \(info[6])\n"
             "Eiweiß in g: \t\t\t\t\t\t\(info[6])\n\n"
             //"Salz in g: \(info[7])\n"
             )
             */
            math.saveToDatabase(
                url: value,
                name: key,
                shop: "NULL",
                genre : "NULL",
                price:"NULL",
                kohlenhydrate: info[4],
                fett: info[2],
                davonZucker:info[5],
                brennwertInKJ:info[0],
                brennwertInKcal: info[1],
                eiweis: info[6],
                ballaststoffe: "NULL",
                salz: "String"
            )
        }
    }
    
    func rotateAnimation(imageView:UIImageView,duration: CFTimeInterval = 2.0) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.greatestFiniteMagnitude;
        
        imageView.layer.add(rotateAnimation, forKey: nil)
    }
    //---------------Refresh DataBase-ENDE---------//
    
    //
    @IBAction func loadData(_ sender: UIButton) {
        math.loadFromDatabase()
    }
    
    //
    
    
    //---------------Animation Definition-STRAT----//
    
    
    //-------------- chipsColor -------------------//
    
    @IBAction func chipsColor(_ sender: UIButton) {
        if(sender.backgroundColor == #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1)){
            sender.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.3019607843, blue: 0.1803921569, alpha: 1)
            // remove old shape layer if any
            //self.shapeLayer?.removeFromSuperlayer()
            
            // create whatever path you want
            let path = UIBezierPath()
            //start
            path.move(to: CGPoint(x: 120, y: 412))
            //mitte
            path.addLine(to: CGPoint(x: 150, y: 412))
            //ende
            path.addLine(to: CGPoint(x: 150, y: 540))
            path.addLine(to: CGPoint(x: 110, y: 540))
            
            // create shape layer for that path
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
            shapeLayer.strokeColor = #colorLiteral(red: 0.9333333333, green: 0.3019607843, blue: 0.1803921569, alpha: 1).cgColor
            shapeLayer.lineWidth = 4
            shapeLayer.path = path.cgPath
            
            // animate it
            view.layer.addSublayer(shapeLayer)
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = 2
            shapeLayer.add(animation, forKey: "MyAnimation")
            
            // save shape layer
            self.shapeLayer = shapeLayer
        }
        else {
            sender.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1)
            
            // create whatever path you want
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 120, y: 412))
            path.addLine(to: CGPoint(x: 150, y: 412))
            path.addLine(to: CGPoint(x: 150, y: 540))
            path.addLine(to: CGPoint(x: 110, y: 540))
            
            // create shape layer for that path
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
            shapeLayer.strokeColor =  #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1).cgColor
            shapeLayer.lineWidth = 4
            shapeLayer.path = path.cgPath
            
            // animate it
            view.layer.addSublayer(shapeLayer)
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = 2
            shapeLayer.add(animation, forKey: "MyAnimation")
            
            // save shape layer
            self.shapeLayer = shapeLayer
            
        }
    }
    //-------------- chipsColor -END----------------//
    
    //-------------- schokoladeColor ---------------//
    
    @IBAction func schokoladeColor(_ sender: UIButton) {
        if(sender.backgroundColor == #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1)){
            sender.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.3019607843, blue: 0.1803921569, alpha: 1)
            
            // create whatever path you want
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 120, y: 450))
            path.addLine(to: CGPoint(x: 140, y: 450))
            path.addLine(to: CGPoint(x: 140, y: 530))
            path.addLine(to: CGPoint(x: 70, y: 530))
            
            // create shape layer for that path
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
            shapeLayer.strokeColor = #colorLiteral(red: 0.9333333333, green: 0.3019607843, blue: 0.1803921569, alpha: 1).cgColor
            shapeLayer.lineWidth = 4
            shapeLayer.path = path.cgPath
            
            // animate it
            view.layer.addSublayer(shapeLayer)
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = 2
            shapeLayer.add(animation, forKey: "MyAnimation")
            
            // save shape layer
            self.shapeLayer = shapeLayer
        }
        else {
            sender.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1)
            
            // create whatever path you want
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 120, y: 450))
            path.addLine(to: CGPoint(x: 140, y: 450))
            path.addLine(to: CGPoint(x: 140, y: 530))
            path.addLine(to: CGPoint(x: 70, y: 530))
            
            // create shape layer for that path
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
            shapeLayer.strokeColor =  #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1).cgColor
            shapeLayer.lineWidth = 4
            shapeLayer.path = path.cgPath
            
            // animate it
            view.layer.addSublayer(shapeLayer)
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = 2
            shapeLayer.add(animation, forKey: "MyAnimation")
            
            // save shape layer
            self.shapeLayer = shapeLayer
            
        }
    }
    //-------------- schokoladeColor -END-----------//
    
    
    @IBAction func trinkenColor(_ sender: UIButton) {
        
        if(sender.backgroundColor == #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1)){
            sender.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.3019607843, blue: 0.1803921569, alpha: 1)
            
            // create whatever path you want
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 120, y: 490))
            path.addLine(to: CGPoint(x: 130, y: 490))
            path.addLine(to: CGPoint(x: 130, y: 520))
            path.addLine(to: CGPoint(x: 30, y: 520))
            
            // create shape layer for that path
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
            shapeLayer.strokeColor = #colorLiteral(red: 0.9333333333, green: 0.3019607843, blue: 0.1803921569, alpha: 1).cgColor
            shapeLayer.lineWidth = 4
            shapeLayer.path = path.cgPath
            
            // animate it
            view.layer.addSublayer(shapeLayer)
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = 2
            shapeLayer.add(animation, forKey: "MyAnimation")
            
            // save shape layer
            self.shapeLayer = shapeLayer
        }
        else {
            sender.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1)
            
            // create whatever path you want
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 120, y: 490))
            path.addLine(to: CGPoint(x: 130, y: 490))
            path.addLine(to: CGPoint(x: 130, y: 520))
            path.addLine(to: CGPoint(x: 30, y: 520))
            
            // create shape layer for that path
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
            shapeLayer.strokeColor =  #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1).cgColor
            shapeLayer.lineWidth = 4
            shapeLayer.path = path.cgPath
            
            // animate it
            view.layer.addSublayer(shapeLayer)
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = 2
            shapeLayer.add(animation, forKey: "MyAnimation")
            
            // save shape layer
            self.shapeLayer = shapeLayer
            
        }
    }
    
    
    @IBAction func fruchtgummiColor(_ sender: UIButton) {
        if(sender.backgroundColor == #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1)){
            sender.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.3019607843, blue: 0.1803921569, alpha: 1)
            
            // create whatever path you want
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 200, y: 412))
            path.addLine(to: CGPoint(x: 160, y: 412))
            path.addLine(to: CGPoint(x: 160, y: 540))
            path.addLine(to: CGPoint(x: 200, y: 540))
            
            // create shape layer for that path
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
            shapeLayer.strokeColor = #colorLiteral(red: 0.9333333333, green: 0.3019607843, blue: 0.1803921569, alpha: 1).cgColor
            shapeLayer.lineWidth = 4
            shapeLayer.path = path.cgPath
            
            // animate it
            view.layer.addSublayer(shapeLayer)
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = 2
            shapeLayer.add(animation, forKey: "MyAnimation")
            
            // save shape layer
            self.shapeLayer = shapeLayer
        }
        else {
            sender.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1)
            
            // create whatever path you want
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 200, y: 412))
            path.addLine(to: CGPoint(x: 160, y: 412))
            path.addLine(to: CGPoint(x: 160, y: 540))
            path.addLine(to: CGPoint(x: 200, y: 540))
            
            // create shape layer for that path
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
            shapeLayer.strokeColor =  #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1).cgColor
            shapeLayer.lineWidth = 4
            shapeLayer.path = path.cgPath
            
            // animate it
            view.layer.addSublayer(shapeLayer)
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = 2
            shapeLayer.add(animation, forKey: "MyAnimation")
            
            // save shape layer
            self.shapeLayer = shapeLayer
            
        }
    }
    
    @IBAction func gebaeckColor(_ sender: UIButton) {
        if(sender.backgroundColor == #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1)){
            sender.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.3019607843, blue: 0.1803921569, alpha: 1)
            
            // create whatever path you want
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 200, y: 450))
            path.addLine(to: CGPoint(x: 170, y: 450))
            path.addLine(to: CGPoint(x: 170, y: 530))
            path.addLine(to: CGPoint(x: 240, y: 530))
            
            // create shape layer for that path
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
            shapeLayer.strokeColor = #colorLiteral(red: 0.9333333333, green: 0.3019607843, blue: 0.1803921569, alpha: 1).cgColor
            shapeLayer.lineWidth = 4
            shapeLayer.path = path.cgPath
            
            // animate it
            view.layer.addSublayer(shapeLayer)
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = 2
            shapeLayer.add(animation, forKey: "MyAnimation")
            
            // save shape layer
            self.shapeLayer = shapeLayer
        }
        else {
            sender.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1)
            
            // create whatever path you want
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 200, y: 450))
            path.addLine(to: CGPoint(x: 170, y: 450))
            path.addLine(to: CGPoint(x: 170, y: 530))
            path.addLine(to: CGPoint(x: 240, y: 530))
            
            // create shape layer for that path
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
            shapeLayer.strokeColor =  #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1).cgColor
            shapeLayer.lineWidth = 4
            shapeLayer.path = path.cgPath
            
            // animate it
            view.layer.addSublayer(shapeLayer)
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = 2
            shapeLayer.add(animation, forKey: "MyAnimation")
            
            // save shape layer
            self.shapeLayer = shapeLayer
            
        }
    }
    
    @IBAction func sonstigesColor(_ sender: UIButton) {
        if(sender.backgroundColor == #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1)){
            sender.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.3019607843, blue: 0.1803921569, alpha: 1)
            
            // create whatever path you want
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 200, y: 490))
            path.addLine(to: CGPoint(x: 180, y: 490))
            path.addLine(to: CGPoint(x: 180, y: 520))
            path.addLine(to: CGPoint(x: 280, y: 520))
            
            // create shape layer for that path
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
            shapeLayer.strokeColor = #colorLiteral(red: 0.9333333333, green: 0.3019607843, blue: 0.1803921569, alpha: 1).cgColor
            shapeLayer.lineWidth = 4
            shapeLayer.path = path.cgPath
            
            // animate it
            view.layer.addSublayer(shapeLayer)
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = 2
            shapeLayer.add(animation, forKey: "MyAnimation")
            
            // save shape layer
            self.shapeLayer = shapeLayer
        }
        else {
            sender.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1)
            
            // create whatever path you want
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 200, y: 490))
            path.addLine(to: CGPoint(x: 180, y: 490))
            path.addLine(to: CGPoint(x: 180, y: 520))
            path.addLine(to: CGPoint(x: 280, y: 520))
            
            
            // create shape layer for that path
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
            shapeLayer.strokeColor =  #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1).cgColor
            shapeLayer.lineWidth = 4
            shapeLayer.path = path.cgPath
            
            // animate it
            view.layer.addSublayer(shapeLayer)
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = 2
            shapeLayer.add(animation, forKey: "MyAnimation")
            
            //save shape layer
            self.shapeLayer = shapeLayer
            
        }
    }
    //-------------Animation DEFINITION END-------------//
    
    //Checkt, welche Buttons grün sind und füllt dementsprechend eine Auswahlliste
    @IBAction func generate(_ sender: UIButton) {
        //Leere Liste mit kommenden Snacks
        var combine : [String : String] = [:]
        if(chips.backgroundColor == #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1) ){
            snacklist.chipsList.forEach { (k,v) in combine[k] = v }
        }
        if(fruchtgummi.backgroundColor == #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1)){
            snacklist.fruchtgummiList.forEach { (k,v) in combine[k] = v }
        }
        if(schokolade.backgroundColor == #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1)){
            snacklist.schokoladeList.forEach { (k,v) in combine[k] = v }
        }
        if(gebaeck.backgroundColor == #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1)){
            snacklist.gebaeckList.forEach { (k,v) in combine[k] = v }
        }
        if(trinken.backgroundColor == #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1)){
            snacklist.getraenkeList.forEach { (k,v) in combine[k] = v }
        }
        if(sonstiges.backgroundColor == #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1)){
            snacklist.sonstigesList.forEach { (k,v) in combine[k] = v }
        }
        if(chips.backgroundColor == #colorLiteral(red: 0.9333333333, green: 0.3019607843, blue: 0.1803921569, alpha: 1) && fruchtgummi.backgroundColor == #colorLiteral(red: 0.9333333333, green: 0.3019607843, blue: 0.1803921569, alpha: 1) && schokolade.backgroundColor == #colorLiteral(red: 0.9333333333, green: 0.3019607843, blue: 0.1803921569, alpha: 1) && gebaeck.backgroundColor == #colorLiteral(red: 0.9333333333, green: 0.3019607843, blue: 0.1803921569, alpha: 1) && trinken.backgroundColor == #colorLiteral(red: 0.9333333333, green: 0.3019607843, blue: 0.1803921569, alpha: 1) && sonstiges.backgroundColor == #colorLiteral(red: 0.9333333333, green: 0.3019607843, blue: 0.1803921569, alpha: 1)){
            resultLabel.text = "Es muss mindestens ein Feld ausgewählt sein!"
            //picture.png wird angezeigt
            imageView.image = #imageLiteral(resourceName: "Picture.png")
            
        }else{
            //Bekommen des Resultstrings
            let result  = math.getRandomSnack(combinedSnackList: combine, sum: combine.count)
            let url : URL = URL(string: result.value)!
            let session = URLSession.shared
            //Bekomme Bild rein
            let task = session.dataTask(with: url, completionHandler: {
                (data, response, error) in
                
                if data != nil{
                    let image = UIImage(data: data!)
                    //Wenn ImageUrl Image enthält, dann zeige an
                    if(image != nil){
                        DispatchQueue.main.async(execute: {
                            self.imageView.image = image
                            self.imageView.alpha = 0
                            //Unnötige Animation
                            //UIView.animate(withDuration: 2.5, animations: {
                            self.imageView.alpha = 1.0
                            //})
                        })
                        
                    }else{
                        //Ansonsten zeige DefaultImage an
                        
                        self.imageView.image = #imageLiteral(resourceName: "Picture.png")
                        self.imageView.alpha = 0
                        //Unnötige Animation
                        //UIView.animate(withDuration: 1.0, animations: {
                        self.imageView.alpha = 1.0
                        //})
                        
                    }
                }
            })
            task.resume()
            resultLabel.text = "Your Snack for today is \n \(result.key) 🎉"
            
            //Übergabe an Public Var
            currentSnack = result.key
        }
    }
    
    override func viewDidLoad() {
        chips.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1)
        schokolade.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1)
        trinken.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1)
        fruchtgummi.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1)
        gebaeck.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1)
        sonstiges.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1)
        //---------------Music Definition-START----------//
        // address of the music file.
        let music = Bundle.main.path(forResource: "Snax", ofType: "mp3")
        // copy this syntax, it tells the compiler what to do when action is received
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: music! ))
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch{
            print(error)
        }
        //---------------Music Definition-ENDE----------//
        
        //---------------Animation Definition-----------//
        // create whatever path you want
        var path = UIBezierPath()
        path.move(to: CGPoint(x: 120, y: 412))
        path.addLine(to: CGPoint(x: 150, y: 412))
        path.addLine(to: CGPoint(x: 150, y: 520))
        
        // create shape layer for that path
        var shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor =  #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1).cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.path = path.cgPath
        
        // animate it
        view.layer.addSublayer(shapeLayer)
        var animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 2
        shapeLayer.add(animation, forKey: "MyAnimation")
        
        // create whatever path you want
        path = UIBezierPath()
        path.move(to: CGPoint(x: 120, y: 450))
        path.addLine(to: CGPoint(x: 140, y: 450))
        path.addLine(to: CGPoint(x: 140, y: 520))
        
        // create shape layer for that path
        shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor =  #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1).cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.path = path.cgPath
        
        // animate it
        view.layer.addSublayer(shapeLayer)
        animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 2
        shapeLayer.add(animation, forKey: "MyAnimation")
        
        
        // create whatever path you want
        path = UIBezierPath()
        path.move(to: CGPoint(x: 120, y: 490))
        path.addLine(to: CGPoint(x: 130, y: 490))
        path.addLine(to: CGPoint(x: 130, y: 520))
        
        // create shape layer for that path
        shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor =  #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1).cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.path = path.cgPath
        
        // animate it
        view.layer.addSublayer(shapeLayer)
        animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 2
        shapeLayer.add(animation, forKey: "MyAnimation")
        
        
        // create whatever path you want
        path = UIBezierPath()
        path.move(to: CGPoint(x: 200, y: 412))
        path.addLine(to: CGPoint(x: 160, y: 412))
        path.addLine(to: CGPoint(x: 160, y: 520))
        
        // create shape layer for that path
        shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor =  #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1).cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.path = path.cgPath
        
        // animate it
        view.layer.addSublayer(shapeLayer)
        animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 2
        shapeLayer.add(animation, forKey: "MyAnimation")
        
        // create whatever path you want
        path = UIBezierPath()
        path.move(to: CGPoint(x: 200, y: 450))
        path.addLine(to: CGPoint(x: 170, y: 450))
        path.addLine(to: CGPoint(x: 170, y: 520))
        
        // create shape layer for that path
        shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor =  #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1).cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.path = path.cgPath
        
        // animate it
        view.layer.addSublayer(shapeLayer)
        animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 2
        shapeLayer.add(animation, forKey: "MyAnimation")
        
        
        // create whatever path you want
        path = UIBezierPath()
        path.move(to: CGPoint(x: 200, y: 490))
        path.addLine(to: CGPoint(x: 180, y: 490))
        path.addLine(to: CGPoint(x: 180, y: 520))
        
        // create shape layer for that path
        shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor =  #colorLiteral(red: 0.1764705882, green: 0.7647058824, blue: 0.6392156863, alpha: 1).cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.path = path.cgPath
        
        // animate it
        view.layer.addSublayer(shapeLayer)
        animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 2
        shapeLayer.add(animation, forKey: "MyAnimation")
        
        //---------------Animation Definition-END-------//
        super.viewDidLoad()
    }
    
    //Bekomme alle variablen aus der Eigentlichen View
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Variable, die auf eine andere Variable in einer anderen View verweist.
        let destination : InfoViewController = segue.destination as! InfoViewController
        destination.resultText = resultLabel.text!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
