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
    
    func testParenthashTagIsParentOfChild() {
        let parent = HashTag("fggfd/fdsds/fdsfd")
        let child = parent.appending("fgfd/trh/gfdgf")
            
        XCTAssertTrue(parent.isParentOf(child))
        XCTAssertFalse(parent.isChildOf(child))
        
    }
    
    func testHashTagIsNotItsOwnParent() {
        let parent = HashTag("fggfd/fdsds/fdsfd")
        
        XCTAssertFalse(parent.isParentOf(parent))
        
    }
    
    func testChildIsChildOfParent() {
        let parent = HashTag("fggfd/fdsds/fdsfd")
               let child = parent.appending("fgfd/trh/gfdgf")
                   
        XCTAssertTrue(child.isChildOf(parent))
        XCTAssertFalse(child.isParentOf(parent))
    }
    
    
    func testHashTagDictionary() {
        
    }

    static var allTests = [
        ("treeContainsAddedTags", treeContainsAddedTags),
        ("treeContainsIntermediateTags", treeContainsIntermediateTags),
        ("testHashTagDictionary", testHashTagDictionary),
        ("testParenthashTagIsParentOfChild", testParenthashTagIsParentOfChild),
    ]
}
