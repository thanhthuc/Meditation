    //
//  Sound.swift
//  Meditation
//
//  Created by Nguyen Thanh Thuc on 05/01/2017.
//  Copyright © 2017 Nguyen Thanh Thuc. All rights reserved.
//

import UIKit

enum SoundType {
    case Repeat
    case Begin
    case End
}
    
class Sound {
    
    var enable: Bool
    var type: SoundType
    var name = ""
    var iterations = 0
    var timeInterval: Double = 300
    
    //MARK Initialization
    
    init(type: SoundType) {
        self.type = type
        self.enable = true
    }
}
    
