//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by admin on 20/03/16.
//  Copyright © 2016 antt. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio : RecordedAudio!
    var audioEngine : AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = try! AVAudioPlayer(contentsOfURL:receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func stopSound(sender: AnyObject) {
        stopAudioPlayerAndEngine()
    }
    @IBAction func playSoundFast(sender: AnyObject) {
        playSound(Constants.SoundSpeed.fast)
    }
    @IBAction func playSlowSound(sender: AnyObject) {
        playSound(Constants.SoundSpeed.slow)
    }
    
    @IBAction func playChipmunk(sender: AnyObject) {
        playSoundWithPitch(Constants.SoundEffect.chipmunk)
    }
    
    
    @IBAction func playDarthVader(sender: AnyObject) {
        playSoundWithPitch(Constants.SoundEffect.darthVader)
    }
    
    @IBAction func playSoundWithEcho(sender: AnyObject) {
        stopAudioPlayerAndEngine()
        
        let echoEffect = AVAudioUnitDelay()
        echoEffect.delayTime = NSTimeInterval(Constants.SoundEffect.Echo.delay)
        echoEffect.feedback = Constants.SoundEffect.Echo.feedback
        
         playSoundWithEffect(echoEffect)
    }
    
    
    @IBAction func playSoundWithReverb(sender: AnyObject) {
        stopAudioPlayerAndEngine()
        
        let reverbEffect = AVAudioUnitReverb()
        reverbEffect.wetDryMix = Constants.SoundEffect.reverb
        
        playSoundWithEffect(reverbEffect)

    }
    
    private func playSoundWithPitch(pitch: Float){
        stopAudioPlayerAndEngine()
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        
        playSoundWithEffect(changePitchEffect)
    }
    
    private func playSoundWithEffect(effect: AVAudioNode){
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)

        audioEngine.attachNode(effect)
        
        audioEngine.connect(audioPlayerNode, to: effect, format: nil)
        audioEngine.connect(effect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    private func playSound(rate: Float){
       stopAudioPlayerAndEngine()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = rate
        audioPlayer.play()

    }
    
    private func stopAudioPlayerAndEngine(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
}
