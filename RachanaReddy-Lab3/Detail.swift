//
//  Detail.swift
//  RachanaReddy-Lab3
//
//  Created by Anya Pawar on 11/19/19.
//  Copyright © 2019 Rachana Reddy. All rights reserved.
//

import UIKit
import AVFoundation

class Detail: UIViewController {
    
    //av player
    var audioPlayer = AVAudioPlayer()

    //count percents
    @IBOutlet var count1: UITextField!
    @IBOutlet var count2: UITextField!
    @IBOutlet var count3: UITextField!
    
    //color boxes
    @IBOutlet var color1: UIView!
    @IBOutlet var color2: UIView!
    @IBOutlet var color3: UIView!
    
    //three bottom boxes (for fun)
    @IBOutlet var bottomcolor1: UIView!
    @IBOutlet var bottomcolor2: UIView!
    @IBOutlet var bottomcolor3: UIView!
    
    //color boxes
    var maxcolor_one: UIColor!
    var maxcolor_two: UIColor!
    var maxcolor_three: UIColor!
    
    var maxper_one: Double!
    var maxper_two: Double!
    var maxper_three: Double!
    
    //song info
    @IBOutlet var song_text: UITextField!
    var song_string: String!
    var song_name: String!
    
    @IBAction func playButton(_ sender: Any) {
    
        let path = Bundle.main.path(forResource: song_string, ofType: ".mp3")!
        let url = URL(fileURLWithPath: path)
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
        }
        catch{
            print("sound error")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        song_text.text = song_name
        //percent
        count1.text = String(maxper_one);
        count2.text = String(maxper_two);
        count3.text = String(maxper_three);
        //color
        
        
        if (maxper_one == 0.0 || count1.text == "nan"){
            color1.backgroundColor = UIColor.white
            bottomcolor1.backgroundColor = UIColor.white
            count1.text = ""
        }
        else{
            color1.backgroundColor = maxcolor_one
            bottomcolor1.backgroundColor = maxcolor_one
        }
        
        if (maxper_two == 0.0 || count2.text == "nan"){
            color2.backgroundColor = UIColor.white
            bottomcolor2.backgroundColor = UIColor.white
            count2.text = ""
        }
        else{
            color2.backgroundColor = maxcolor_two
            bottomcolor2.backgroundColor = maxcolor_two
        }
        
        if (maxper_three == 0.0 || count3.text == "nan"){
            color3.backgroundColor = UIColor.white
            bottomcolor3.backgroundColor = UIColor.white
            count3.text = ""
        }
        else{
            color3.backgroundColor = maxcolor_three
            bottomcolor3.backgroundColor = maxcolor_three
        }
        
    }
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backButton(_ sender: Any) {
        audioPlayer.stop()
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        audioPlayer.pause()
    }
    


}


