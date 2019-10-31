//
//  File.swift
//  
//
//  Created by Vincent Peeters on 10/31/19.
//

import Foundation

public protocol HashTagCarrier {
    
    var hashTags: Set <HashTag> { get set }
    
    mutating func add(_ hashTag: HashTag)
    
    mutating func remove(_ hashTah: HashTag)
    
    mutating func replace(_ from: HashTag, with to: HashTag)
    
}

public extension HashTagCarrier {
    
    mutating func add(_ hashTag: HashTag) {
        self.hashTags.insert(hashTag)
    }
    
    mutating func remove(_ hashTag: HashTag) {
        _ = self.hashTags.remove(hashTag)
    }
    
    mutating func replace(_ from: HashTag, with to: HashTag) {
        self.remove(from)
        self.add(to)
    }
    
}
