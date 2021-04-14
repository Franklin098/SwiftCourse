//
//  ViewController.swift
//  Xylophone
//
//  Code by Franklin098
//

import UIKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController{
    
    var audioPlayer:AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func notePressed(_ sender: UIButton) {
        
        let name = "note\(sender.tag)"
        let url = Bundle.main.url(forResource: name, withExtension: "wav")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer.play()
        } catch let error  {
            print(error)
        }
    }
}

