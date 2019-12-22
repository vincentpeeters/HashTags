import XCTest
@testable import HashTags

final class HashTagsTests: XCTestCase {
    
    func testTreeContainsAddedTags() {
        
        let locations = HashTag("locations")
        let indoor = locations.appending("indoor")
        let outdoor = locations.appending("outdoor")
        
        let activities = HashTag("activities")
        let dancing = activities.appending("dancing")
        
        let swift = HashTag("languages/swift")
        
        let set = Set(arrayLiteral: locations, indoor, outdoor, dancing, activities, swift)
        
        let tree = HashTag.Node(from: set)
        
        
        
        XCTAssertTrue(tree.children.contains { $0.hashTag == HashTag("//locations///") })
        
    }
    
    func testTreeContainsIntermediateTags() {

        let locations = HashTag("locations")
        let indoor = locations.appending("indoor")
        let outdoor = locations.appending("outdoor")
        
        let activities = HashTag("activities")
        let dancing = activities.appending("dancing")
        
        let swift = HashTag("Programming/languages/swift")
        
        let set = Set([locations, indoor, outdoor, dancing, activities, swift])
        
        let tree = HashTag.Node(from: set)
        
        
        XCTAssertTrue(tree.offspring.contains { $0.hashTag == HashTag("Programming/languages") })
        
    }
    
    func testRemovingHastagInTreeRemovesHashtag() {
        let locations = HashTag("locations")
        let indoor = locations.appending("indoor")
        let outdoor = locations.appending("outdoor")
        
        let activities = HashTag("activities")
        let dancing = activities.appending("dancing")
        
        let swift = HashTag("Programming/languages/swift")
        
        let set = Set([locations, indoor, outdoor, dancing, activities, swift])
        
        var tree = HashTag.Node(from: set)
        
        tree.remove(swift)
        
         XCTAssertFalse(tree.offspring.contains { $0.hashTag == swift })
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
    
    func testLastComponent() {
        let tag1 = HashTag("test")
        XCTAssertEqual(tag1.lastComponent, "test")
        XCTAssertEqual(tag1.appending("sub").lastComponent, "sub")
        XCTAssertEqual(HashTag("///%%bhjdshj&&&nfdjsknjd/dmdskf///dfnsk/jdjkds/last").lastComponent, "last")
    }
    
    
    func testHashTagHasCorrectComponents() {
        let tag = HashTag("///%%bhjdshj&&&nfdjsknjd/dmdskf///dfnsk/jdjkds/last")
         XCTAssertEqual(tag.components, ["bhjdshjnfdjsknjd","dmdskf","dfnsk","jdjkds","last"])
    }

//    static var allTests = [
//        ("treeContainsAddedTags", treeContainsAddedTags),
//        ("treeContainsIntermediateTags", treeContainsIntermediateTags),
//        ("testHashTagDictionary", testHashTagDictionary),
//        ("testParenthashTagIsParentOfChild", testParenthashTagIsParentOfChild),
//        ("testLastComponent", testLastComponent),
//    ]
    
}
