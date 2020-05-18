//
//  ViewController.swift
//  RachanaReddy-Lab3
//
//  Created by Rachana Reddy on 10/12/19.
//  Copyright © 2019 Rachana Reddy. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    var inTitle: String!
    var inImage: UIImage?
    
    @IBOutlet weak var new: DrawingView!
    @IBOutlet weak var text: UITextField!
    var currentWidth = CGFloat(10)
    var currentColor = UIColor.red
    var currentAlpha = CGFloat(10)
    var currentStroke: Stroke?
    
    
    var redCount: Count = Count(color: UIColor.red, count: 0)
    var orangeCount: Count = Count(color: UIColor.orange, count: 0)
    var yellowCount: Count = Count(color: UIColor.yellow, count: 0)
    var greenCount: Count = Count(color: UIColor.green, count: 0)
    var blueCount: Count = Count(color: UIColor.blue, count: 0)
    var purpleCount: Count = Count(color: UIColor.purple, count: 0)
    
    var countArray: [Count] = []
    
    var max1_p: Double = 0.0
    var max2_p: Double = 0.0
    var max3_p: Double = 0.0
    
    var max1_color: UIColor = UIColor.white
    var max2_color: UIColor = UIColor.white
    var max3_color: UIColor = UIColor.white
    
    var song_string_local: String = ""
    var song_name_local: String = ""
    

    //outlets
    
    @IBOutlet weak var UndoWarning: UILabel!
    @IBOutlet weak var WidthLabel: UILabel!
    @IBOutlet weak var OpacityLabel: UILabel!
    @IBOutlet var DrawingView: DrawingView!
    @IBOutlet weak var WidthSlider: UISlider!
    @IBOutlet weak var OpacitySlider: UISlider!
    
    @IBOutlet weak var draaa: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.title = "New Project";
        text.text = inTitle
        draaa.image = inImage
        self.view.sendSubviewToBack(draaa)
        self.view.sendSubviewToBack(new)
        
    }
    
    //color selection buttons
    @IBAction func useRed(_ sender: UIButton) {
        currentColor = UIColor.red
    }
    @IBAction func useOrange(_ sender: UIButton) {
        currentColor = UIColor.orange
    }
    @IBAction func useYellow(_ sender: UIButton) {
        currentColor = UIColor.yellow
    }
    @IBAction func useGreen(_ sender: UIButton) {
        currentColor = UIColor.green
    }
    @IBAction func useBlue(_ sender: UIButton) {
        currentColor = UIColor.blue
    }
    
    @IBAction func usePurple(_ sender: Any) {
        currentColor = UIColor.purple
    }
    
    
    //clear button function
    @IBAction func clear(_ sender: Any) {
        new.currentStroke = nil
        new.strokesInView = []
        redCount = Count(color: UIColor.red, count: 0)
        orangeCount = Count(color: UIColor.orange, count: 0)
        yellowCount = Count(color: UIColor.yellow, count: 0)
        greenCount = Count(color: UIColor.green, count: 0)
        purpleCount = Count(color: UIColor.purple, count: 0)
        blueCount = Count(color: UIColor.blue, count: 0)
        generateCounts();
        findMax();
    }
    
  
    //override touches functions -> get data from user input
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: view) else { return }
        currentStroke = Stroke(points: [touchPoint], width: CGFloat(WidthSlider!.value * 20), color: currentColor, alpha: CGFloat(OpacitySlider!.value))
        currentStroke!.points.append(touchPoint)
        new.strokesInView.append(currentStroke!) //add the current Stroke to strokes in view array
        UndoWarning.textColor = UIColor.clear //makes warning label clear
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: view) else { return }
        new.strokesInView.removeLast()
        currentStroke!.points.append(touchPoint)
        new.strokesInView.append(currentStroke!) //add the current Stroke to strokes in view array
        UndoWarning.textColor = UIColor.clear //makes warning label clear
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: view) else { return }
        new.strokesInView.removeLast()
        currentStroke!.points.append(touchPoint)
        new.strokesInView.append(currentStroke!) //add the current Stroke to strokes in view array
        UndoWarning.textColor = UIColor.clear //makes warning label clear
    }
    
    
    
    
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        
        if (self.isMovingFromParent){
            
            let renderer = UIGraphicsImageRenderer(size: new.bounds.size)
            let image = renderer.image { ctx in
                new.drawHierarchy(in: new.bounds, afterScreenUpdates: false)
            }
            
            let newtitle = text.text ?? "New Project"
            //let newtitle = self.title ?? "New Project"//(String)(LoadAllDrawings().count + 1)
            
            if(FindDrawing(title: newtitle) == nil){
                print("name not taken, saving...")
                SaveImage(image: image, title: newtitle)
            } else {
                print("name taken, overwriting...")
                DeleteDrawing(title: newtitle)//self.title ?? "New Project")
                SaveImage(image: image, title: newtitle)//self.title ?? "New Project")
            }
            
            print(LoadAllDrawings().count)
            
        }
    }
    
    
    func generateCounts() {
        countArray.removeAll()
        for stroke in new.strokesInView {
            if (stroke.color == UIColor.red) {
                redCount.count += stroke.points.count
                //print("red: ", redCount);
            } else if (stroke.color == UIColor.orange) {
                orangeCount.count += stroke.points.count
               // print("orange: ", orangeCount);
            } else if (stroke.color == UIColor.yellow) {
                yellowCount.count += stroke.points.count
                //print("yellow:", yellowCount);
            } else if (stroke.color == UIColor.green) {
                greenCount.count += stroke.points.count
                //print("green:", greenCount);
            } else if (stroke.color == UIColor.blue) {
                blueCount.count += stroke.points.count
                //print("blue:", blueCount);
            } else if (stroke.color == UIColor.purple) {
                purpleCount.count += stroke.points.count
                //print("purple:", purpleCount);
            }
        }
    }
    
    func findMax() {
        countArray.append(redCount);
        countArray.append(orangeCount);
        countArray.append(yellowCount);
        countArray.append(greenCount);
        countArray.append(blueCount);
        countArray.append(purpleCount);
       // print("before sort:", countArray);
        
        countArray.sort()
        //print("after sort:", countArray)
        
        let max1 = countArray[countArray.count - 1];
        let max2 = countArray[countArray.count - 2];
        let max3 = countArray[countArray.count - 3];
        
        let total_count = redCount.count + orangeCount.count + yellowCount.count + greenCount.count + blueCount.count + purpleCount.count;
        
        let max1_count = max1.count;
        let max2_count = max2.count;
        let max3_count = max3.count;
        
        max1_p = round(10.0*((Double(max1_count) / Double(total_count))*100))/10.0;
        max2_p = round(10.0*((Double(max2_count) / Double(total_count))*100))/10.0;
        max3_p = round(10.0*((Double(max3_count) / Double(total_count))*100))/10.0;
        
        max1_color = max1.color;
        max2_color = max2.color;
        max3_color = max3.color;

        
//        print("top 1: ", max1)
//        print("top 2: ", max2)
//        print("top 3: ", max3)
//
//        print("top 1 info : ", max1_count,  " ", max1_color)
//        print("top 2 info : ", max2_count,  " ", max2_color)
//        print("top 3 info : ", max3_count,  " ", max3_color)
//
//        print("total count: ", total_count)
//
//        print("top 1 percent : ", max1_p)
//        print("top 2 percent : ", max2_p)
//        print("top 3 percent : ", max3_p)
        
    }
    
    func findSong(){
        print(max1_color)
        print(max2_color)
        print(max3_color)
        
        //red
        //UIExtendedSRGBColorSpace 1 0 0 1
        
        //orange
        //UIExtendedSRGBColorSpace 1 0.5 0 1
        
        //yellow
        //UIExtendedSRGBColorSpace 1 1 0 1
        
        //green
        //UIExtendedSRGBColorSpace 0 1 0 1
        
        //blue
        //UIExtendedSRGBColorSpace 0 1 0 1
        
        //purple
        //UIExtendedSRGBColorSpace 0.5 0 0.5 1
        
        if (max1_color == UIColor(red: 1, green: 0, blue: 0, alpha: 1)){
            print("we have red")
            song_name_local = "I Write Sins Not Tragedies"
            song_string_local = "red"
        }
        if (max1_color == UIColor(red: 1, green: 0.5, blue: 0, alpha: 1)){
            print("we have orange")
            song_name_local = "Misery Business"
            song_string_local = "orange"
        }
        if (max1_color == UIColor(red: 1, green: 1, blue: 0, alpha: 1)){
            print("we have yellow")
            song_name_local = "Best Day of My Life"
            song_string_local = "yellow"
        }
        if (max1_color == UIColor(red: 0, green: 1, blue: 0, alpha: 1)){
            print("we have green")
            song_name_local = "The Walker"
            song_string_local = "green"
        }
        if (max1_color == UIColor(red: 0, green: 0, blue: 1, alpha: 1)){
            print("we have blue")
            song_name_local = "When I Was Your Man"
            song_string_local = "blue"
        }
        if (max1_color == UIColor(red: 0.5, green: 0, blue: 0.5, alpha: 1)){
            print("we have purple")
            song_name_local = "Say You Won't Let Go"
            song_string_local = "purple"
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "generateID"{
            
            let nextVC = segue.destination as? Detail
            //colors
            nextVC?.maxcolor_one = self.max1_color
            nextVC?.maxcolor_two = self.max2_color
            nextVC?.maxcolor_three = self.max3_color
            //percents
            nextVC?.maxper_one = self.max1_p
            nextVC?.maxper_two = self.max2_p
            nextVC?.maxper_three = self.max3_p
            //song info
            nextVC?.song_string = self.song_string_local
            nextVC?.song_name = self.song_name_local
        }
    }
    
    
    @IBAction func generate(_ sender: Any) {
        generateCounts();
        findMax();
        findSong();
      //  self.performSegue(withIdentifier: "generateID", sender: self)
    }
   
    
}

