//
//  File.swift
//  
//
//  Created by Vincent Peeters on 10/31/19.
//

import Foundation

public extension HashTag {
    
    struct Tree {
        
        public var root: Node = Node(hashTag: .empty)
        
        public init(from hashTags: Set<HashTag> ) {
            for hashTag in hashTags {
                root.insert(hashTag)
            }
        }
        
    }
    
}

public extension HashTag.Tree {
    
    struct Node {
        
        init(hashTag: HashTag) {
            self.hashTag = hashTag
        }
        
        public private(set) var hashTag: HashTag
        
        public private(set) var children: Set<Node> = []
        
        fileprivate mutating func insert(_ hashTag: HashTag) {
            if let firstUp = hashTag.firstTagUp(from: self.hashTag) {
                if !children.contains { $0.hashTag == firstUp } {
                    children.insert(Node(hashTag: firstUp))
                }
//                var child = children.first { $0.hashTag == firstUp }
//                child?.insert(hashTag)
                
                if var child = children.first(where:  { $0.hashTag == firstUp }) {
                    children.remove(child)
                    child.insert(hashTag)
                    children.insert(child)
                }
                
                
//                self.child(with: firstUp).insert(hashTag)
            }
        }
        
//        private mutating func child(with hashTag: HashTag) -> Node {
//
//            children.first { $0.hashTag == hashTag }.
//
//            if let node = children.first(where: { $0.hashTag == hashTag }) {
//                return node
//            } else {
//                let node = Node(hashTag: hashTag)
//                children.insert(node)
//                return node
//            }
//        }
        
    }
    
    
    
}

extension HashTag.Tree.Node: Hashable {
    
    public static func == (lhs: HashTag.Tree.Node, rhs: HashTag.Tree.Node) -> Bool {
        
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


