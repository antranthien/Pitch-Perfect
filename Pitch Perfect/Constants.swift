//
//  Constants.swift
//  Pitch Perfect
//
//  Created by admin on 21/03/16.
//  Copyright © 2016 antt. All rights reserved.
//

import Foundation

struct Constants{
    struct RecordLabelStatus {
        static let ready = "Tap to record"
        static let recording = "Recording"
    }
    
    static let recordName = "myrecord.wav"
    
    struct Seque {
        static let stopRecording = "stopRecording"
    }
    
    struct SoundEffect {
        static let chipmunk : Float = 1000
        static let darthVader : Float = -1000
        
        struct Echo {
            static let feedback : Float = 25
            static let delay = 0.25
        }
        
        static let reverb : Float = 40
    }
    
    struct SoundSpeed {
        static let fast : Float = 2
        static let slow : Float  = 0.5
    }
}

