//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by admin on 20/03/16.
//  Copyright © 2016 antt. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    @IBOutlet weak var recordingLabel: UILabel!

    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio : RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func stopRecording(sender: AnyObject) {
         recordingLabel.text = Constants.RecordLabelStatus.ready
         audioRecorder.stop()
         let session = AVAudioSession.sharedInstance()
         try! session.setActive(false)
        
    }
    @IBAction func recordButton(sender: AnyObject) {
        recordingLabel.text = Constants.RecordLabelStatus.recording
        
        stopButton.hidden = false
        recordButton.enabled = false
        
        // Get DocumentDirectory path
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let recordingName = Constants.recordName
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    override func viewWillAppear(animated: Bool) {
        setInitialStateForControls()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            //Save the record
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            
            // Perform seque
            
            self.performSegueWithIdentifier(Constants.Seque.stopRecording, sender: recordedAudio)

        }
        else {
            setInitialStateForControls()
            print("Recording was not successful")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == Constants.Seque.stopRecording){
            let playSoundsVC : PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            
            let data = sender as! RecordedAudio
            
            playSoundsVC.receivedAudio = data
        }
    }
    
    private func setInitialStateForControls(){
        // By default, the stop button should be hidden and the record button is enabled and the label is "Tap to record"
        stopButton.hidden  = true
        recordButton.enabled = true
        recordingLabel.text = Constants.RecordLabelStatus.ready
        
    }
}

