//
//  File.swift
//  
//
//  Created by Vincent Peeters on 10/31/19.
//

import Foundation


public extension HashTag {
    
    static func carrierDictionary<Carrier: HashTagCarrier>(from carriers: [Carrier]) -> [HashTag: [Carrier]] {
        let sequence: [(hashtag: HashTag, carrier: Carrier)] = Array(
            carriers.map { carrier in carrier.hashTags.map { hashtag in (hashtag, carrier) } }.joined())
        return Dictionary(grouping: sequence) { $0.hashtag }
            .mapValues{ $0.map { $0.carrier } }
    }
    
}
