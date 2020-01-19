//
//  File.swift
//  
//
//  Created by Vincent Peeters on 19/01/2020.
//

import Foundation

extension Character {
    
    @available(iOS 10.2, OSX 10.12.2, *)
//    @available( *)
    private var isSimpleEmoji: Bool {
        guard let firstProperties = unicodeScalars.first?.properties else {
            return false
        }
        return unicodeScalars.count == 1 &&
            (firstProperties.isEmojiPresentation ||
                firstProperties.generalCategory == .otherSymbol)
    }
    
    private var isCombinedIntoEmoji: Bool {
        return unicodeScalars.count > 1 &&
            unicodeScalars.contains {
                $0.properties.isJoinControl ||
                    $0.properties.isVariationSelector
        }
    }
    
    var isEmoji: Bool {
        guard #available(iOS 10.2, OSX 10.12.2, *) else { return false }
        return isSimpleEmoji || isCombinedIntoEmoji
    }
    
}
