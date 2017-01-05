//
//  Segment.swift
//  Meditation
//
//  Created by Nguyen Thanh Thuc on 05/01/2017.
//  Copyright © 2017 Nguyen Thanh Thuc. All rights reserved.
//

import UIKit

enum SegmentType {
    case main
    case warmUp
    case coolDown
}

class Segment {
    var enable: Bool
    var type: SegmentType
    var sounds = [Sound]()
    var duration: Double = 300
    
    init(type: SegmentType) {
        self.type = type
        self.enable = true
    }
    
    func soundOfType(type: SoundType) -> Sound? {
        var result: Sound? = nil
        for sound in sounds {
            if sound.type == type {
                result = sound
            }
        }
        return result
    }
}
