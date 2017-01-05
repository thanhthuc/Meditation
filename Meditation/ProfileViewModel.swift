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
    
    func numOfRowForSegmentOfType(type: SegmentType) -> Int {
        var result = 1
        guard let segment = profile.segmentOfType(type: type) else {return result}
        
        switch type {
        case .warmUp:
            result = segment.enable ? 2:1
        default:
            result = 1
        }
        
        return result
    }
}
