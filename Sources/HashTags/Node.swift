//
//  File.swift
//  
//
//  Created by Vincent Peeters on 10/31/19.
//

import Foundation



public extension HashTag {
    
    struct Node {
        
        init(hashTag: HashTag) {
            self.hashTag = hashTag
        }
        
        init(from hashtags: Set<HashTag>) {
            self.hashTag = .empty
            for tag in hashtags { self.insert(tag) }
        }
        
        public private(set) var hashTag: HashTag
        
        public private(set) var children: Set<Node> = []
        
        public var offspring: Set<Node> {
            let children = self.children.flatMap { Array($0.offspring) }
            return Set(children + [self])
        }
        
        public mutating func insert(_ hashTag: HashTag) {
            if let firstUp = hashTag.firstTagUp(from: self.hashTag) {
                if !children.contains { $0.hashTag == firstUp } {
                    children.insert(Node(hashTag: firstUp))
                }
                
                if var child = children.first(where:  { $0.hashTag == firstUp }) {
                    children.remove(child)
                    child.insert(hashTag)
                    children.insert(child)
                }
            }
        }
        
        /// Removes the exact hashtag and any of its children from the tree, but leaves all parent hashtags
        public mutating func remove(_ hashTag: HashTag) {
            if let child = children.first(where: { $0.hashTag == hashTag }) {
                children.remove(child)
            } else if var child = children.first(where: { $0.hashTag.isParentOf(hashTag) }) {
                children.remove(child)
                child.remove(hashTag)
                children.insert(child)
            }
        }
        
    }
    
    
    
}

extension HashTag.Node: Hashable {
    
    public static func == (lhs: HashTag.Node, rhs: HashTag.Node) -> Bool {
        
        guard lhs.hashTag == rhs.hashTag else { return false }
        return lhs.children == rhs.children
        
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashTag.path)
        for child in children {
            hasher.combine(child)
        }
    }

}


