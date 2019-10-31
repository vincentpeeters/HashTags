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
    
    private let allowedCharacters = "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890/"
    
    public var wrappedValue: String {
        get { string }
        set(newString) {
            let sanatized = String(newString
                .filter { allowedCharacters.contains($0) }
                .lowercased()
            )
            let components = sanatized.split(separator: "/")
            self.string = components.joined(separator: "/")
            
        }
    }
    
}
