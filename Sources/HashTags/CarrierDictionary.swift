//
//  File.swift
//  
//
//  Created by Vincent Peeters on 10/31/19.
//

import Foundation


public extension HashTag {
    
    static func carrierDictionary(from carriers: [HashTagCarrier]) -> [HashTag: [HashTagCarrier]] {
        let sequence: [(hashtag: HashTag, carrier: HashTagCarrier)] = Array(
            carriers.map { carrier in carrier.hashTags.map { hashtag in (hashtag, carrier) } }.joined())
        return Dictionary(grouping: sequence) { $0.hashtag }
            .mapValues{ $0.map { $0.carrier } }
    }
    
}
