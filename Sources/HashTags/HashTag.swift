import Foundation


public struct HashTag {
    
    @TagPath public var path: String
    
    public init(_ path: String) {
        self.path = path
    }
    
    
    //MARK: - Public Methods and computed vars
    
    public var components: [String] {
        path.split(separator: "/").map { String($0) }
    }
    
    public func appending(_ pathComponent: String) -> HashTag {
        HashTag("\(self.path)/\(pathComponent)")
    }
    
    public var lastComponent: String {
        components.last ?? ""
    }
    
    public func isParentOf(_ potentialChild: HashTag) -> Bool {
        guard potentialChild.components.count > self.components.count else { return false }
        return self.components == Array(potentialChild.components.prefix(self.components.count))
    }
    
    public func isChildOf(_ potentialParent: HashTag) -> Bool {
        potentialParent.isParentOf(self)
    }
    
    
    //MARK: - Internal Methods and computed vars
    
    internal func firstTagUp(from shorterTag: HashTag) -> HashTag? {
        if let component = self.firstPathComponentUp(from: shorterTag) {
            return shorterTag.appending(component)
        } else {
            return nil
        }
    }
    
    
    static var empty: HashTag { HashTag("") }
    
    
    //MARK: - Private methods
    

    private func firstPathComponentUp(from ShorterTag: HashTag) -> String? {
        guard Array(self.components.prefix(ShorterTag.components.count)) == ShorterTag.components else { return nil }
        return self.components.suffix(self.components.count - ShorterTag.components.count).first
    }
    
    
}

extension HashTag: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.path)
    }
    
}

extension HashTag: Equatable {
    
    public static func == (lhs: HashTag, rhs: HashTag) -> Bool {
        lhs.path == rhs.path
    }
    
    
}

