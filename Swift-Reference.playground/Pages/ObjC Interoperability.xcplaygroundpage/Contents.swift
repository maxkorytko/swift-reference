//: [See Also: Swift Reference](Swift)

import UIKit

//: INTERACTING WITH OBJECTIVE-C APIs

//: Initializers

// When ObjC initializers come over to Swift, they take on native Swift initialier syntax.
// initWith gets sliced off.

// UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectZero
//                                                         style:UITableViewStyleGrouped]

var tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)

// ObjC factory methods get mapped as convenince initializers in Swift.

// UIColor *color = [UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:1.0];

let color = UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)

// In ObjC a getter may be called using property syntax.
// This is not the case in Swift.
// Only properties that are written using @property syntax in ObjC are imported as properties.

//: Methods

// The first part of an ObjC method selector becomes the base method name.
// The first argument appears immediately inside the parentheses, without a name.
// The rest of the selector pieces correspond to argument names and go inside the parentheses.

// [tableView insertSubview:subview atIndex:2];

tableView.insertSubview(UIView(frame: CGRect.zero), at: 2)
tableView.reloadData()

//: id Compatibility

// Swift imports id as AnyObject.
// AnyObject is a protocol that allow you to write type-safe Swift code
// while maintaining the flexibility of an untyped object.

var myObject: AnyObject = UITableViewCell()
myObject = NSDate()

// Use can call any ObjC methods and properties without casting.
let futureDate: AnyObject = myObject.addingTimeInterval(10)
let timeSinceNow = myObject.timeIntervalSinceNow

// If, however, you're calling a method that does not exist, you'll get a run time error.
// Use optional chaining in Swift to call methods and properties on an AnyObject instance.

let myCount = myObject.count
let myChar = myObject.characterAtIndex?(5)
if let firstCharacter = myObject.characterAtIndex?(0) {
    print("Found the first character: \(firstCharacter)")
}

// Downcasts may also fail. Optionals to the rescue!

let userDefaults = UserDefaults.standard
let lastRefreshDate = userDefaults.object(forKey: "LastRefreshDate")
if let date = lastRefreshDate as? NSDate {
    print(date.timeIntervalSinceReferenceDate)
}

// If you're certain of the type of an object and know it's not nil, just use 'as!'.

//: Working with nil

// Swift makes all classes in argument and return types optional in imported ObjC APIs.
// This is because ObjC does not make any guarantees that an object is non-nil.
// Swift imports object types as implicitly unwrapped.
// Before you use an ObjC object, you should check that it's not missing,
// unless you're absolutely certain.

//: Extensions

// Extensions in Swift are similar to categories in Objective-C.
// Use them to add the following to existing classes:
// - methods
// - computed properties (instance and class)
// - conform to a protocol
//
// You can not use extensions to override existing methods or properties on ObjC types.

//: Closures

// ObjC blocks are automatically imported as Swift closures.
// Closures and blocks are compatible, so you can pass closures to ObjC methods expecting blocks.
// Variable captured by closures are mutable.
// In ObjC you need to mark them with __block to be mutable rather than copied.

//: Object Comparison

// There are two comparison operators in Swift: == (equality) and === (identity).
// == compares the contents of the objects.
// === determines if variables or constants refer to the same object.
// Swift automatically invokes 'isEqual:' method on classes inherited from NSObject.

//: Swift Type Compatibility

// When you define a Swift class that inherits from NSObject or any other ObjC class,
// the class is automatically compatible with ObjC.
// If, however, a Swift class does not derive from an ObjC class,
// you can use @objc attribute to make it available in ObjC.
// Use @objc attribute before any member of a class that you want to use in ObjC.
// If your class inherits from an ObjC class, the compiler adds this attributes automatically.
// The compiler does not add it automatically for 'private' members, however.

// When you use Swift API in ObjC, the compiler performes direct translation.
// EX:
// func playSong(name: String)
// - is translated into -
// - (void)playSong:(NSString *)name

// For initializers, the compiler adds 'initWith' to the beginning and capitalizes the first character.
// EX:
// init(songName: String, artist: String)
// - is translated into -
// - (instancetype)initWithSongName:(NSString *)songName artist:(NSString *)artist

//: ObjC Selectors

// Any ObjC selector is a type that refers to the name of an ObjC method.
// In Swift, ObjC selectors are represented by the Selector structure.
// Selectors can be constructed using a String literal.
// EX: let mySelector: Selector = "tappedButton:"

class MyViewController: UIViewController {
    let myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        myButton.addTarget(self, action: #selector(MyViewController.tappedButton(sender:)), for: .touchUpInside)
    }
    
    func tappedButton(sender: UIButton!) {
        print("tapped button")
    }
}

//: WRITING SWIFT CLASSES WITH OBJ-C BEHAVIOR

// Interoperability lets you define classes that incorporate ObcC behavior.
// Compiler does much of the bridging.

//: Integrating with IB

// @IBOutlet, @IBAction
// To enable live, interactive custom view design in IB, use @IBDesignable and @IBInspectable.

//: Specifying Property Attributes

// Swift properties are stong by default.
// Weak properties must have an optional class type.
// Use 'let' to create a read-only property.
// Use 'var' to create a read-write property.
// Provide a getter only for a computed property to make it read-only.

//: Using Swift Class Names with ObjC APIs

// Swift classes are namespaced based on the module they are compiled in.
// For example, a fully qualified class name could be MyApp.MyClassName.
// Swift classes are exposed to the ObjC runtime with their fully qualified names.
// If you use string representation of Swift classes, you must use their fully qualified names.

//: WORKING WITH COCOA DATA TYPES

// Swift automatically converts some data types to and from ObjC.
// There are also some data types that can be used interchangeably with ObjC.
// Convertable and interchangeable data types are called bridged data types.

//: Strings

// Swift automatically bridges between String and NSString classes.
// There should be no need to use NSString in Swift code.
// If you do need to use NSString, you can cast to Swift String using 'as'.

//: Numbers

let n = 42
let m: NSNumber = NSNumber(value: n)

// These types are automatically bridged to NSNumber:
// Int, UInt, Float, Double, Bool

//: Collections

// Swift automatically bridges NSArray and NSDictionary classes.

// After you bridge an NSArray to a Swift array, the array type is [AnyObject].
// You can downcast the array to a more specific type.
// This is not guaranteed to succeed, so you need to use optional cast.

let foundationArray: NSArray = [1, 2, 4]
let swiftArray = foundationArray

if let downcastedSwiftArray = swiftArray as? [UIView] {
    // downcatedSwiftArray contains only UIView objects
}

// direct downcast, which may result in a runtime error
for number in foundationArray as! [NSNumber] {
    print(number)
}

// When you cast from a Swift array to an NSArray object,
// the elements in the Swift array must be AnyObject compatible.

// You can create an NSArray from Swift. Make sure to explicitly set the type to NSArray.
let schoolSupplies: NSArray = ["Pencil", "Eraser", "Notebook"]

//: Dictionaries

// When you bridge from NSDictionary to Swift dictionary,
// the resulting dictionary is of type [NSObject: AnyObject].
// As with arrays you can downcast to a more specific type.

// When you cast from a Swift dictionary to NSDictionary,
// all instances of keys and values must be bridgeable to ObjC.

// For the most part, the rules for bridging/casting to and from Swift are the same as for arrays.

//: Foundation Data Types and Functions

let rect = CGRect(x: 50, y: 50, width: 100, height: 100)
let width = rect.width // same as CGRectGetWidth(rect)
let maxX = rect.maxX // same as CGRectGetMaxX(rect)

// Swift bridges NSUInteger and NSInteger to Int.

// NSAssert function do not carry over to Swift. Use 'assert' function instead.

//: Error Handling

// Swift automatically translates ObjC methods that produce errors into methods that
// throw an error according to Swift's native error handling functionality.

// If the last non-block parameter of an ObjC method is of type NSError**, Swift replaces it with 'throws'.

// EX: -(BOOL)removeItemAtURL:(NSURL *)url error:(NSError **)error
// - is translated into -
// func removeItemAtURL(url: NSURL) throws
// Notice that the return type is Void.

// If an error producing ObjC method returns an object (which means it can return nil),
// Swift changes the return type to an non optional type.

//: Singleton

// In ObjC you use 'dispatch_once' to create singletons.
// In Swift, you create a static type property, which is guaranteed to be lazily initialized only once.

class Singleton {
    static let sharedInstance = Singleton()
}
