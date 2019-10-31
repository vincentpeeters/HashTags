//
//  File.swift
//  
//
//  Created by Vincent Peeters on 10/31/19.
//

import Foundation

public extension HashTag {
    
    class Tree {
        
        public let root: Node = Node(hashTag: .empty)
        
        public init(from hashTags: Set<HashTag> ) {
            for hashTag in hashTags {
                root.insert(hashTag)
            }
        }
        
    }
    
}

public extension HashTag.Tree {
    
    class Node {
        
        init(hashTag: HashTag) {
            self.hashTag = hashTag
        }
        
        public private(set) var hashTag: HashTag
        
        public private(set) var children: Set<Node> = []
        
        fileprivate func insert(_ hashTag: HashTag) {
            if let firstUp = hashTag.firstTagUp(from: self.hashTag) {
                self.child(with: firstUp).insert(hashTag)
            }
        }
        
        private func child(with hashTag: HashTag) -> Node {
            if let node = children.first(where: { $0.hashTag == hashTag }) {
                return node
            } else {
                let node = Node(hashTag: hashTag)
                children.insert(node)
                return node
            }
        }
        
    }
    
    
    
}

extension HashTag.Tree.Node: Hashable {
    
    public static func == (lhs: HashTag.Tree.Node, rhs: HashTag.Tree.Node) -> Bool {
        lhs.hashTag == rhs.hashTag
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashTag.path)
    }

}


