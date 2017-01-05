//
//  Profile.swift
//  Meditation
//
//  Created by Nguyen Thanh Thuc on 05/01/2017.
//  Copyright © 2017 Nguyen Thanh Thuc. All rights reserved.
//

import UIKit

enum ProfileSection: Int {
    case Time, WarmUp, CoolDown, Count
    
    static var count = {
        return ProfileSection.Count.rawValue
    }
    
    static let sectionTitles = [Time: "Time", WarmUp: "Warm up", CoolDown: "Cool down"]
    
    func sectionTitle() -> String {
        if let sectionTitle = ProfileSection.sectionTitles[self] {
            return sectionTitle
        } else {
            return ""
        }
    }
}

class Profile {
    
    var name = "Profile"
    var segments = [Segment]()
    var duration: TimeInterval = 450
    
    init() {
        //create main segment
        let segment = Segment(type: .main)
        
        //add segment to profile
        segments.append(segment)
    }
    
    func segmentOfType(type: SegmentType) -> Segment? {
        
        
        
        return segments.first
    }
}
