//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by admin on 21/03/16.
//  Copyright © 2016 antt. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL, title : String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}
