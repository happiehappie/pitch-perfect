//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jack Xiong Lim on 3/25/15.
//  Copyright (c) 2015 Jack Xiong Lim. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slowSound(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.play()
        
    
    }

    @IBAction func fastSound(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 1.5
        audioPlayer.currentTime = 0.0
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.play()
    }
    
    @IBAction func playChipmunksSound(sender: UIButton) {
        playAudioWithVariablePitch(1000)
        
        
    }
    
    @IBAction func playDarthVaderSound(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    
    func playAudioWithVariablePitch(pitch: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    
    @IBAction func stopSound(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
