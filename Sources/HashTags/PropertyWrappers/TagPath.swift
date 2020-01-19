//
//  File.swift
//  
//
//  Created by Vincent Peeters on 10/31/19.
//

import Foundation

@propertyWrapper public struct TagPath {
    
    public init(){}
    
    private var string = ""
        
    public var wrappedValue: String {
        get { string }
        set(newString) {
            let sanatized = String(newString
                .filter { $0 == "/" || $0.isLetter || $0.isEmoji || $0.isWhitespace || $0.isNumber || $0.isSymbol || $0.isCurrencySymbol || $0.isPunctuation }
                .filter { $0 != "#" }
            )
            let components = sanatized.split(separator: "/")
            self.string = components.joined(separator: "/")
        }
    }
    
}


