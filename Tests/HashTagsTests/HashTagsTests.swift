import XCTest
@testable import HashTags

final class HashTagsTests: XCTestCase {
    
    func treeContainsAddedTags() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let locations = HashTag("locations")
        let indoor = locations.appending("indoor")
        let outdoor = locations.appending("outdoor")
        
        let activities = HashTag("activities")
        let dancing = activities.appending("dancing")
        
        let swift = HashTag("languages/swift")
        
        let set = Set(arrayLiteral: locations, indoor, outdoor, dancing, activities, swift)
        
        let tree = HashTag.Tree(from: set)
        
        
        
        XCTAssertTrue(tree.root.children.contains { $0.hashTag == HashTag("//locations///") })
        
    }
    
    func treeContainsIntermediateTags() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let locations = HashTag("locations")
        let indoor = locations.appending("indoor")
        let outdoor = locations.appending("outdoor")
        
        let activities = HashTag("activities")
        let dancing = activities.appending("dancing")
        
        let swift = HashTag("Programming/languages/swift")
        
        let set = Set(arrayLiteral: locations, indoor, outdoor, dancing, activities, swift)
        
        let tree = HashTag.Tree(from: set)
        
        
        
        XCTAssertTrue(tree.root.children.contains { $0.hashTag == HashTag("Programming/languages") })
        
    }

    static var allTests = [
        ("treeContainsAddedTags", treeContainsAddedTags),
    ]
}
