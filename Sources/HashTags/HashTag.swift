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
    
    
    //MARK: - Internal Methods and computed vars
    
    func firstTagUp(from shorterTag: HashTag) -> HashTag? {
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

