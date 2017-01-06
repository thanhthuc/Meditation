//
//  ProfileViewModel.swift
//  Meditation
//
//  Created by Nguyen Thanh Thuc on 05/01/2017.
//  Copyright © 2017 Nguyen Thanh Thuc. All rights reserved.
//

import UIKit

class ProfileViewModel: NSObject {
    var profile: Profile
    
    init(profile: Profile) {
        self.profile = profile
    }
    
    func timeForProfile() -> String {
        return stringFromTimeInterval(timeInterval: profile.duration)
    }
    
    func timeForSegmentOfType(type: SegmentType) -> String {
        guard let segment = profile.segmentOfType(type: type) else { return "00:00" }
        return stringFromTimeInterval(timeInterval: segment.duration)
    }
    
    private func stringFromTimeInterval(timeInterval: Double) -> String {
        let timeInterval = Int(timeInterval)
        
        let hours = (timeInterval / 3600)
        let seconds = (timeInterval % 60)
        let minutes = ((timeInterval / 60) % 60)
        
        if hours  > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    func numOfRowsForSegmentOfType(type: SegmentType) -> Int {
        var result = 1
        guard let segment = profile.segmentOfType(type: type) else {return result}
        
        switch type {
        case .warmUp:
            result = segment.enable ? 2:1
            
        case .coolDown:
            if segment.enable {
                result = (segment.soundOfType(type: .Begin) != nil) ? 4 : 3
            }
        default:
            result = 1
        }
        
        return result
    }
    
    func segmentOfTypeEnabled(type: SegmentType) -> Bool {
        guard let segment = profile.segmentOfType(type: type) else { return false }
        return segment.enable
    }
    
    func setSegmentOfType(type: SegmentType, enable: Bool) {
        if let segment = profile.segmentOfType(type: type) {
            //set segment enable
            segment.enable = enable
        } else {
            //create segment
            let segment = Segment(type: type)
            segment.enable = enable
            profile.segments.append(segment)
        }
    }
    
    func setSoundOfType(type: SoundType, enable: Bool, forSegmentOfTime: SegmentType) {
        
    }
    
    func nameSoundOfType(type: SoundType, forSegmentOfType: SegmentType) -> String {
        var nameSound = ""
        if type == .Begin {
            nameSound = "Begin"
        } else if type == .Repeat {
            nameSound = "Repeat"
        } else {
            nameSound = "End"
        }
        return nameSound
    }
}






