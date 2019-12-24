//
//  File.swift
//  
//
//  Created by Vincent Peeters on 10/31/19.
//

import Foundation


public extension HashTag {
    
    static func carrierDictionary<Carrier: HashTagCarrier>(from carriers: Set<Carrier>) -> [HashTag: Set<Carrier>] {
        
        let keysAndValues =
        carriers.map { carrier in carrier.hashTags.map { hashtag in (hashtag, carrier) } }.joined()
        
        return Dictionary(grouping: Array(keysAndValues)) { $0.0 }
            .mapValues{ Set($0.map { $0.1 }) }
        
    }
    
}
