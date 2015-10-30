import Foundation

// Swift Version 2.0

// A quick reference to all the Swift features.
// Source: The Swift Programming Language -> Language Guide by Apple
// URL: https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-XID_454

//: TUPLES

let httpResponse = (200, "OK")

// docompose the tuple
let (statusCode, statusMessage) = httpResponse

// ignoring some of the tuple's values
let (justTheStatusCode, _) = httpResponse

// access tuples' value by index starting from 0
httpResponse.0
httpResponse.1

// you can name individual elements in a tuple
let http200Status = (statusCode: 200, description: "OK")
http200Status.statusCode
http200Status.description

let (x, y) = (1, 2)

//: OPTIONALS

// Swift's optionals let you indicate the absense of a valid value for any type.
// Access the optional's value with !, which is known as forced unwrapping.
// Use it when you know for sure that there is value in an optional.
// If you try to use ! for an optional without a value, you'll get a runtime error.

let possibleNumber = "123"
let convertedNumber = Int(possibleNumber) // returned type is Int?

// An optional with a value evaluated to 'true'
if convertedNumber != nil {
    print(convertedNumber!) // safe to use forced unwrapping, since we are sure there is a value
} else {
    // value could not be converted to Int
}

// this is called optional binding
if let actualNumber = Int(possibleNumber) {
    // convertion successfull
    // use 'actualNumber' without !
    // it's value has been set to the value of the optional returned from toInt()
} else {
    // value could not be converted to Int
}

// Implicitly unwrapped optional is a normal optional, but can also be used like a nonoptional value.
// Implicitly unwrapped optional must have a value, otherwise a runtime error is triggered.

let assumedString: String! = "Notice ! instead of ?"
print(assumedString)

//: USING NIL

// use nil to indicate an absence of a value in an optional
// nil can only be used with optionals
// unlike in Objective-C, nil is NOT a pointer in Swift

var serverResponseCode: Int? = 403
serverResponseCode = nil

var str: String? // str is set to nil automatically

// Use nil coalescing operator to unwrap an optional or return a default value.
// Note that, if the value of 'carColor' in the example below is not nil,
// the value of 'color' will not be evaluated.
// This is know as short-circuit evaluation.

let color = "red"
var carColor: String? // this defaults to nil
var finalColor = carColor ?? color
// this is the same as 'finalColor = carColor != nil ? carColor! : color'

//: RANGE OPERATOR

// Closed range includes both lower and upper bounds
for index in 1...5 {
    print("index \(index)")
}

// Half-open range includes the lower bound, but does not include the upper bound
for index in 1..<5 {
    print("index \(index)")
}

//: STRINGS

let immutableName = "Max"

var mutableName = "Max"
mutableName += " Korytko"

immutableName.characters.count

print("This is an example of string interpolation. \(2 * 2)")

// String Equality
// Two strings are equal when they contain exactly the same characters in exactly the same order

if mutableName == immutableName {}

// MARK: ARRAYS

// all elements of an array are of the same type

var emptyArray: [Int] = [] // same as: var emptyArray = Int[]()

var someInts = [Int](count: 5, repeatedValue: 1)
var anotherSomeInts = Array(count: 5, repeatedValue: 1) // array type is inferred

var shoppingList = ["Eggs", "Milk"]
shoppingList.count
shoppingList.isEmpty
shoppingList.append("Flour")
shoppingList += ["Baking Powder"] // same as append()
shoppingList += ["Cheese", "Butter"]
shoppingList[3]

// array slicing

var slice = shoppingList[1..<3]
slice[0..<1] = ["Bananas", "Apples"]
slice.insert("Oranges", atIndex: 0)
slice.removeLast() // same as: slice.removeAtIndex(slice.count - 1)

// combining arrays

var result = [1, 2, 3] + [4, 5, 6]

// iterating over an array

for item in shoppingList {}

for (index, value) in shoppingList.enumerate() {}

//: DICTIONARIES

// dictionaries are unordered
// all keys and values of a dictionary are of the same type

var emptyDictionary = Dictionary<Int, String>()

// airport dictionary inferred type is Dictionary<String, String>
var airports = ["TYO":"Tokyo", "YYZ":"Toronto"] // create a dictionary with a dictionary literal

airports.count
airports["LHR"] = "London" // adds a new pair to the dictionary
airports["LHR"] = "London Heathrow"

// updates an existing values and returns the old value
// creates a new value and returns nil otherwise
//
if let oldValue = airports.updateValue("Dublin", forKey: "DUB") {
    true
} else {
    false
    airports
}

airports["DUB"] = nil // removes a pair from the dictionary
airports.removeValueForKey("LHR") // returns the removed value

for (airportCode, airportName) in airports {}

let airportNames = Array(airports.values) // creates an array of values

airports = [:]

//: COLLECTION MUTABILITY

// If you declare a collection (array or dictionary) with var, it's mutable.
// You can change both, the size and elements of the collection.
// If you declare a collection with let, it's immutable.
// You can not change the collection size.
// IMPORTANT: immutable array allows changing a value for an existing index
//            immutable dictionary does NOT allow changing a value for a key


//: CONTROL FLOW

for name in ["a", "b", "c"] {}

for (key, value) in ["key1":"value1", "key2":"value2"] {}

for var index = 0; index < 3; ++index {}

for index in 0...3 {}

var i = 0
while (i < 5) { i++ }

repeat {
    i--
    // continue and break work exactly the same as in Objective-C
} while (i > 0)

let someCharacter = "e"

switch someCharacter {
case "a", "e", "i":
    // the body of each case must contain at least one line of executable code
    print("\(someCharacter) is a vowel")
    // no 'break' is required, since switch statements do not fall through in Swift
    // if you need to fall through for some reason, use the 'fallthrough' keyword
case "b", "c", "d":
    print("\(someCharacter) is a consonant")
default:
    // we need the default case, because switch must be exhaustive
    print("I don't know what \(someCharacter) is")
}

// range matching

let age = 45

switch age {
case 1..<13:
    print("Baby")
case 13..<20:
    print("Teenager")
default:
    print("Grownup")
}

// tuples and value binding

let point = (0, 0)

switch point {
case (0, 0): print("origin")
case (1, 1): break // This is how you can ignore a case. The code after the switch will be executed next.
case (-2...2, -2...2): print("within the bounds")
case(_, 0): print("somewhere at the top")
case (let x, 0) where x > 5: print("\(x) on the x axis") // this is value binding
case let (x, y): print("\(x) on x and \(y) on y") // this case is exhaustive, so no default is necessary
}

// labeled statements
i = 0

myLoop: while (i < 10) {
    switch i {
    case 5: break myLoop // without a labeled statement, break would termitate the switch, not the loop
    default: i++
    }
}

func sumAny(params: Any...) -> String {
    return String(params.map { param in
        switch param {
        case "" as String, 0 as Int:
            return -10
        case let s as String where Int(s) > 0:
            return Int(s)!
        case is Int:
            return param as! Int
        default:
            return 0
        }
    }.reduce(0){$0 + $1})
}

let resultEmpty = sumAny()
let result1 = sumAny(Double(), 10, "-10", 2)
let result2 = sumAny("Martin Todorov", 2, 22, "-3", "10", "", 0, 33, -5)

//: FUNCTIONS

// void function
func sayHelloWorld() {
    print("Hello, World!")
    // returns Void (which is an empty tuple) implicitly
}

func sayHelloWorld() -> String {
    return "Hello, World!"
}

func sayHello(name: String) -> String {
    return "Hello, \(name)!"
}

// Function parameters are constants by default.
// If you want to get a copy of an argument, and change it, use the 'var' keyword.
//
func sayHello2(var name: String) -> String {
    name += "!"
    return "Hello, \(name)"
}

// returning multiple values from a function using named tuples
func count(string: String) -> (vowels: Int, consonants: Int, others: Int) {
    let vowels = 0, consonants = 0, others = 0
    
    // implementation
    
    return (vowels, consonants, others)
}

let total = count("some string!")
print("\(total.vowels), \(total.consonants), \(total.others)")

// External parameter names.
// They help make function parameters clear and unambiguous.
//
func someFunction(externalParameterName localParameterName: Int) {}

func join(string s1: String, toString s2: String, withJoiner joiner: String) -> String {
    return s1 + joiner + s2
}

join(string: "Hello", toString: "World!", withJoiner: ", ")

// By default, the first parameter omits its external name.
// All subsequent parameter names have the same external name as their local name.
//
func containsCharacter(string: String, characterToFind: Character) -> Bool {
    for character in string.characters {
        if character == characterToFind { return true }
    }
    
    return false
}

let containsAVee = containsCharacter("aardvark", characterToFind: "v")

// default parameter values
func defaultJoin(string s1: String, toString s2:String, withJoiner joiner: String = " ") -> String {
    return s1 + joiner + s2
}

defaultJoin(string: "Hello", toString: "World!")

// External names for parameters with default values.
// If no external name is provided for a parameter with a default value,
// Swift automatically creates an external name for it, which matches the parameter name.
// You must use the external name when calling the function and providing a value other than a default one.
//
func defaultJoiner2(s1: String, s2: String, joiner: String = " ") -> String {
    return s1 + joiner + s2
}

defaultJoiner2("Hello", s2: "World")
defaultJoiner2("Hello", s2: "World", joiner: ", ")

// In-Out parameters allow passing a variable to a function, and let the function change it.
// The caller of the function will see the changes made by the function.
// The argument you pass to such a function must be a variable.
// You can not use constants or literals.
// Prepend an argument name with '&' when calling a function.
//
func swapInts(inout a: Int, inout b: Int) {
    let tmp = a
    a = b
    b = tmp
}

var a = 3, b = 4
swapInts(&a, b: &b)

func swapIntsInOneLine(inout a: Int, inout b: Int) {
    (a, b) = (b, a)
}

swapIntsInOneLine(&a, b: &b)


//: FUNCTION TYPES

// Every function has a specific function type, made up of the param type and return type.
// You can use a function type just like any other type in Swift.
// Functions can have function type parameters and return function types as well.

func printMathResults(mathFunction: (Int, Int) -> Int, a: Int, b: Int) {
    print("Result: \(mathFunction(a, b))")
}

func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    // These two functions are nested.
    // They are not accessible by the outside functions.
    // Only the enclosing function can access them.
    // Nested functions have access to the outer function parameters.
    
    func stepForward(input: Int) -> Int {
        return input + 1
    }
    
    func stepBackward(input: Int) -> Int {
        return input - 1
    }
    
    return backwards ? stepBackward : stepForward
}

// Be aware that you can not call a nested function from another nested function in Swift.
// You will get compiler error you do this:

func someFunctionA() {
    func someNestedFunctionB() {
        
    }
    
    func someNestedFunctionC() {
        // you should get a compiler error: 'Cannot reference a local function with capture from another local function'
        someNestedFunctionB()
    }
}

//: CLOSURES

// Closures are self-contained blocks of functionality that can be passed around.
// They are similar to blocks in Objective-C.
// Global and nested functions are special cases of closures.
// Global functions are the functions that are defined at a global scope.

let names = ["Max", "Peter", "John", "Barry"]

func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}

var reversed = names.sort(backwards)

// closure expression syntax has the following general form:

// {(params) -> return type in
//      statements
// }

reversed = names.sort({ (s1: String, s2: String) -> Bool in
    return s1 > s2
})

// when passing a closure to a function as a parameter,
// it's always possible to infer the parameter and return types
//
reversed = names.sort({ s1, s2 in return s1 > s2 })

// single-expression closures can implicitly return the result of their single expression
reversed = names.sort({ s1, s2 in s1 > s2 })

// Swift automatically provides shorthand argument names to inline closures.
// Therefore, you can omit the closure's argument list from its definition.
// In such case, the 'in' keyword can also be omitted.

reversed = names.sort({ $0 > $1 })

// If a function accepts a closure as its final argument,
// you can write the closure as a trailing closure.
// If a function has a single argument, which is a closure, you can omit the parentheses.

reversed = names.sort { $0 > $1 }

// If you don't need a parameter passed to the closure, you can replace its name with an underscore.

func handleEvent(handler: (event: String) -> Void) -> Void {
    handler(event: "LearnSwift")
}

handleEvent() { _ in
    print("I am handling an event")
}

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]

let numbers = [15, 58, 198]
let strings = numbers.map {
    (var number) -> String in
    var output = ""
    
    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    
    return output
}

// Capturing Values

func makeIncrementor(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    
    // Nested function is the simplest form of a closure in Swift.
    func incrementor() -> Int {
        runningTotal += amount
        return runningTotal
    }
    
    return incrementor
}

var incrementor = makeIncrementor(forIncrement: 10)
incrementor()
incrementor()

incrementor = makeIncrementor(forIncrement: 7)
incrementor()
incrementor()

// Closures are reference types.
let alsoIncrementor = incrementor
alsoIncrementor()

//: ENUMERATIONS

// The values defined in an enumeration are the member values of that enumeration.
// Enumerations in Swift are first-class types in their own right.
// They adopt many feature traditionaly supported only by classes.

enum Age {
    case Yong, Adult, Old // multiple members can appear on a single line
}

enum CompassPoint {
    case North // this member value is NOT assigned default value of 0
    case South
    case East
    case West
}

var directionToHead = CompassPoint.North
// once directionToHead is initialized, you can change its value using a shorter syntax
directionToHead = .South

switch directionToHead {
case .North:
    print("North")
case .South:
    print("South")
default: // case must be exhaustive
    print("East Or West")
    
}

// Enumerations are value types.
// When you assing one enum to another, a copy is made.

var directionToHead2 = directionToHead
directionToHead2 = .West // directionToHead is not affected

// Enumeration can be defined to store values of multiple types.

// The enumeration below can be read as:
// Define an enumeration type called Barcode, which can take either a value of UPCA
// with an associated value of type (Int, Int, Int, Int),
// or a value of QRCode with an associteated value of type String.
enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}

var productBarcode = Barcode.UPCA(8, 32, 23242, 0)
productBarcode = .QRCode("AGADGBDAFDA") // the value in productBarcode is replaced with QRCode

// The different types can be checked using a switch statement.
// Associated values can be extracted as part of the switch statement.

switch productBarcode {
case .UPCA(let numberSystem, let manufacturer, let product, let check):
    print("UPCA")
case .QRCode(let productCode):
    print("QRCode")
}

// If all associated values are extracted as constants or variables, use a shorter syntax:
// 'case let .UPCA(numberSystem, manufacturer, product, check):'

// Enumeration values can come prepopulated with different values (called raw values),
// which are all of the same type.

enum ASCIIControlCharacter: Character {
    case Tab = "\t" // each raw value must be unique within the enum declaration
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

// below is an example of autoincrementation
enum Planet: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

let earthsOrder: Int = Planet.Earth.rawValue

// If you define an enumeration with a raw value type, the enumeration automatically receives an initializer
// that takes a value of the raw value's type (called rawValue), and returns enumeration member or nil.
let possiblePlanet = Planet(rawValue: 7)

if let possiblePlanet = Planet(rawValue: 7) { print(possiblePlanet) }
else { print("No such planet exists") }

//: CLASSES AND STRUCTURES

struct Resolution {
    var width = 0 // data type is infered from the assigned value
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let someResolution = Resolution(width: 1024, height: 768)
let someVideoMode = VideoMode()
someVideoMode.resolution = someResolution

// Structures are value types.
// Structures are always passed by value.
// Classes are reference types.
// Classes are always passed by reference.

// Swift's String, Array, and Dictionary types are implemented as structures!

let someOtherVideoMode = VideoMode()

// Use identity operator to check if two references refer to the same instance
if someVideoMode === someOtherVideoMode {
    print("Two references refer to the same instance")
}

if someVideoMode !== someOtherVideoMode {
    print("Two references refer to different instances")
}

// Use the equality operator (==) to check if two objects are equal.
// Object equality is defined by their classes.

// Static members

class Car {
    let brand: String
    let make: String
    
    init(brand: String, make: String) {
        self.brand = brand
        self.make = make
    }
    
    class func bmwM5() -> Car {
        return Car(brand: "BMW", make: "M5")
    }
}

var bmw = Car.bmwM5()
print(bmw.make)

//: PROPERTIES

struct FixedLengthRange {
    // these are stored properties
    var firstValue: Int
    let length: Int
}

var rangeOfThreeItem = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItem.firstValue = 10

// If you create an instance of a structure and assign it to a constant,
// you can not modify its properties, even the variable ones.
// This is because structres are value types.
// The same is NOT true for classes.

let rangeOfFourItems = FixedLengthRange(firstValue:0, length: 4)
// rangeOfFourItems.firstValue = 6 <-- error here

// Create lazy properties by marking a stored property with 'lazy' keyword.
// lazy var myProperty: Int
// Lazy properties are evaluated when they are first used.
// Constant properties can not be marked lazy.

// Classes, structures, and enumerations can also have computed properties.
// Computed properties do not actually store a value.

struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    
    // this is a computed property
    // computed properties must be variable properties, because their value is not fixed
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set /*(newCenter) - you can provide a custom name for the setter argument */ {
            // newValue is automatically defined by the compiler
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
    
    // this is a computed read-only property
    // notice that the 'get' is ommited to take advantage of the shorter syntax
    //
    var area: Double {
        return size.width * size.height
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
square.area

// Property Observers

// willSet and didSet observers are called whenever the property is assigned a new value.
// This is true even if the new value is the same as the current value.
// The observers are NOT called when a property is first initialized.

class StepCounter {
    // this is a stored property with property observers
    var totalSteps: Int = 0 {
        willSet {
            print("About to set totalSteps to \(newValue)")
        }
        didSet {
            if (totalSteps > oldValue) {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360

// Type properties belong to the type itself.
// There is only one copy of these properties no matter how many instances of that type exist.
// Type properties are useful for defining type constants.

struct SomeStructure {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 1
    }
}

// For classes, you can only define computed type properties
class SomeClass {
    class var computedTypeProperty: Int {
        return 1
    }
}

print(SomeStructure.storedTypeProperty)
print(SomeClass.computedTypeProperty)

//: METHODS

// Classes, structures, and enumerations can have methods.
// Methods are functions that are associated with a type.

class Counter {
    var count = 0
    
    func increment() {
        incrementBy(1)
    }
    
    func incrementBy(amount: Int) {
        incrementBy(amount, numberOfTimes: 1)
    }
    
    // External parameter names for methods are different from functions.
    // For the function below, Swift will automatically generate external names for all parameters,
    // except the first one.
    // If you do not want Swift to generate external parameter names, use _ in place of an external
    // parameter name.
    //
    func incrementBy(amount: Int, numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
    
    func reset() {
        // every instance has an implicit property called 'self'
        self.count = 0
    }
}

// Properties of a value type (structure or enumeration) can not be modified from within its instance
// methods.
// If your method needs to modify an instance property, mark the method as 'mutating'
// mutating func moveByX(deltaX: Double, y deltaY:Double)

// Type methods are similar to class methods in Objective-C.
// Mark a type method with 'class' for classes.
// Mark a type method with 'static' for structures and enums.
// Within a type method, 'self' refers to the type itself.

//: SUBSCRIPTS

// Subscripts enable you to query instances of a type by using square brackets syntax.
// Subscripts can be read-write or readonly.

struct TimesTable {
    let multiplier: Int
    
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let threeTimesTable = TimesTable(multiplier: 3)
threeTimesTable[6]

/* This is an example of a read-write subscript
subscript(index: Int) -> Double {
get {
// return an appropriate value here
}
set {
// default 'newValue' parameter is provided for the setter
}
*/

//: INHERITANCE

// In Swift, a class does not inherit from a common base class by default.
// A subclass can override the following of its base class: instance method, instance property,
// class method, class property, subscript.

// When overriding, use the 'override' keyword.
// Use 'super' to refer to the super class.

// A read-only property can be overriden to make it a read-write property.

// Prevent a method or property from being overriden by marking it with a 'final' keyword.
// You can also mark an entire class as final.

//: INITIALIZATION

// Unlike Objective-C, initializers in Swift do not return a value.
// Classes and structures must set all of their stored properties to an appropriate value.
// Stored properties can not be left in an indeterminate state.

struct Fahrenheit {
    // you can also initialize this property by providing its default value
    var temperature: Double
    
    init() {
        temperature = 32.0
    }
}

struct Color {
    let red, green, blue: Double
    
    // Unlike methods, the compiler automatically creates external parameter names for initializers.
    // These external parameter names are the same as parameter names.
    //
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}

// it's not possible to call an initializer without using external parameter names
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)

// If you don't want to use an external parameter, use _ in its place.

struct Celsius {
    var temperature: Double
    
    init(fromFarenheit fahrenheit: Double) {
        temperature = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperature = kelvin - 273.15
    }
    
    init(_ celsius: Double) {
        temperature = celsius
    }
}

let bodyTemperature = Celsius(36.6)

class ServeyQuestion {
    let text: String
    
    // optional properties will be automatically assigned 'nil'
    var response: String?
    
    init(text: String) {
        // although text property is declared using 'let', the initializer can set its value
        // it can not be modified by subclasses, however
        //
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}

// Default initializers

class ShoppingListItemClass {
    var name: String?
    var quantity = 1
    var pruchased = false
    
    // Since this is a base class (it does not inherit from any other class), and no initializer is provided,
    // the compiler creates a default initializer.
    // This is possible because all properties are assigned defult values.
}

var item = ShoppingListItemClass()

struct Size2 {
    var width = 0.0
    var height = 0.0
    
    // The compiler automatically generates memberwise initializer for this structure.
}

let twoByTwo = Size2(width: 2.0, height: 2.0)

// Initializer delegation

// Class and value types have different rules for initializer delegation.
// This is because classes can inherit from other classes, while value types can not.
// For value types use 'self.init' to invoke an initializer from another initializer.

// Classes may have designated, convenience, and failable initializers.
// A given class must have at least one designated initializer.
// Designated intializer is responsible for setting initial values for all properties.
// A class is not initialized until all properties receive an initial value.
// Convenience initializers must always call a designated initalizer form the same class (never super).
// For this reason, convenience initializers are said to delegate 'across'.

// In Swift, initialization is a two-phase process.

// In the first phase, each property is assigned a value by the designated initializer from the class
// that introduced the properties.
// The first phase is called the initialization phase.

// In the second phase, a class is given the opportunity to customize property values.
// The second phase is called the customization phase.

// Swift compiler performs four safety checks to ensure the class is properly initialized.
// Read about the four safety steps in the 'Two-Phase Initialization' section in the Swift guide.

// The basic idea is the following:
// A class is created by either calling its designated or convenience initializer.
// If a convenience intializer is called, it must call another convenience or designated initializer
// before setting values for any of the properties.
// Once the designated intializer is called, it must first set initial values for all properties that
// this class introduced.
// Then, if the class extends another class, it must call the super designated initializer.
// This chain of method calls will continue to go 'up', until a class that does not extend
// any other class is reached, and its designated initializer is called.
// This signals the end of phase one, and from this moment on, the call chain goes back 'down'.
// Now, phase two begins, and each class can customize values for inherited properties.


// Initializers are not inherited by default in Swift.
// However, super class initializers are automatically inherited if certain conditions are met.
// These conditions are the following (provided that the class sets default values for all
// properties it introduces):
// - if the class does not define any designated initializers, it inherits all of its super class
//   designated initializers
// - if the class provides an implementation of all of its super class designated initializers,
//   it inherits all of the super class convenience initializers

// Read 'Automatic Initializer Inheritance' section in the Swift guide for more details.

// The code sample below illustrates two-phase initialization and automatic initializer inheritance.
// https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-XID_306
// Navigate to the 'Designated and Convenience Initializers in Action' section for more details.

class Food {
    var name: String
    
    // this is the designated initializer
    // it must set initial values for all properties introduced by this class
    // it must also call 'up' to the super class designated initializer
    // however, there is no super class in this case
    //
    init(name: String) {
        self.name = name
    }
    
    // this is a convenience initializer
    // it must call 'across' to the designated initializer
    convenience init() {
        self.init(name: "[Unnamed]")
        
        // implement any customization here
    }
}

let namedMeat = Food(name: "Bacon") // Bacon
let unnamedMeat = Food()// [Unnamed]

class RecipeIngredient: Food {
    var quantity: Int
    
    init(name: String, quantity: Int) {
        // this class introduced a new property, so it must initialize it first
        self.quantity = quantity
        
        super.init(name: name)
        
        // implement any customization here
    }
    
    // this initializer takes the same parameters as the designated initializer in Food
    // for this reason, it must be marked with the 'override' modifier
    override convenience init(name: String) {
        // delegate 'across' to the designated initializer
        self.init(name: name, quantity: 1)
    }
}

let oneUnnamedItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sigEggs = RecipeIngredient(name: "Eggs", quantity: 6)

// This class provides a default value for each of the properties it introduces.
// Also, it does not introduce any new designated initializers.
// For this reason, this class inherits all the designated and convenience initializers.
class ShoppingListItem: RecipeIngredient {
    var purchased = false
    
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? "â" : "â"
        return output
    }
}

// Initializer can be marked with a 'required' keyword.
// In this case any subclass must implement this initializer.

// A stored property value can be provided by a global function or a closure.

class SomeClass2 {
    let someProperty: Int = {
        // do something...
        return 0
        }() // we're calling this closure immediately. Otherwise it will be assigned to the property.
}

// Sometimes it's useful to define a type for which the initializatin may fail.
// To achieve, this create a failable initializer.

struct Animal {
    let species: String
    
    // This is a failable initializer
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        
        self.species = species
    }
}

var someCreature = Animal(species: "Giraffe") // the returned type is Animal? not Animal

// Classes have more complex requirements in regards to failable initializers.
// See 'Failable Initializers for Classes' section in the Swift guide.

//: DEINITIALIZATION

// Deinitializers are only available on class types and there can only be one deinitializer in a class.
// Swifts calls 'deinit' method automatacally.
// This method returns nothing and has no parameters.

class TestDeinit {
    deinit {
        // do something
    }
}

//: AUTOMATIC REFERENCE COUNTING

// Weak references are allowed to have no value.
// For this reason, you must declare every weak reference as having an optional type.
// Use the 'weak' keyword to define a weak reference.

// An unowned reference does not keep a strong hold on the instance in refers to.
// An unowned reference is assumed to always have a value, so it's always defined as a non-optional type.
// Use the 'unowned' keyword to define an unowned reference.
// If you try to access an unowned reference after the intstance that it references is deallocated,
// you will trigger a runtime error.
// Swift guarantees that the app crashes realiably in such case, so that there is no unexpected behavior.

class Customer {
    let name: String
    var card: CreditCard?
    
    init(name: String) {
        self.name = name
    }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
}

var john: Customer?
john = Customer(name: "John")
john!.card = CreditCard(number: 123_213, customer: john!)
john = nil

// Unowned references and implicitly unwrapped optional properties

class Country {
    let name: String
    var capitalCity: City!
    
    init(name: String, capitalName: String) {
        self.name = name
        // without making 'capitalCity' property an optional, the object would not be fully initialized at this point
        // we would not be able to pass self to City initializer
        // we make 'capitalCity' property implicitly unwrapped optional to emphasize that the value must not be nil
        //
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

//: OPTIONAL CHAINING

class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
    
    func printNumberOfRooms() {
        print("The number of room \(numberOfRooms)")
    }
}

let max = Person()
// this will trigger a runtime error: john.residence!.numberOfRooms <- residence is nil

// this tells Swift to chain on the optional 'residence' property
// the attempt to access the optional property may fail, so the returned type is Int?
// this is true despite that numberOfRooms has Int type (not optional Int)
//
if let roomCount = max.residence?.numberOfRooms { // this is called optional binding
    print(roomCount)
} else {
    print("Unable to retrieve number of rooms")
}

// Calling a method with optional chaining and determining it the call was successfull

if max.residence?.printNumberOfRooms() != nil {
    print("The call was successful")
}

// When accessing subscripts through optional chaining, place ? before []
// If a subscript returns a value of optional type, place ? after []

var testScores = ["Dave": [87, 23, 9], "Max": [134, 9, 1]]
testScores["Dave"]?[0] = 91
testScores["Unknown"]?[0]++

// If the type you're trying to retrieve through optional chaining is not optional,
// it will become optional.
// If the type is already optional, it will not become more optional. (??)

//: TYPE CASTING

// Use 'is' to check types: 'if item is Movie'
// Use 'as' or 'as?' to downcast superclass to a subclass.
// 'as?' is often used with optional binding.

// if let someObject = someOtherObject as? SomeType

// as? return nil if type casting fails.
// as results in a runtime error if type casting fails.

// 'AnyObject' is an alias for a type that can represent an instance of any class type.
// 'Any' is an alias for a type that can represent an instance of any type, except for function types.

//: NESTED TYPES

struct BlackjackCard {
    // nested Suite enum
    enum Suite: Character {
        case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
    }
}

let heartsSymbol = BlackjackCard.Suite.Hearts.rawValue

// Nested types can be nested inside other nested types.

//: EXTENSIONS

// Extensions add new functionality to an existing class, structure, or enumeration type.
// Extensions are similar to categories in Objective-c, but do not have names.
// Extentions in Swift can:
// - add computed properties and computed static properties
// - define instance methods and type methods
// - provide new initializers
// - define subscripts
// - define and use new nested types
// - make an existing type conform to a protocol

// Extentions CAN NOT override existing functionality, however.

extension Double {
    // these are computed readonly instance properties (no 'get' required)
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var mile: Double { return self.km * 1.6 }
}

let oneMile = 1.mile

// Extensions can add new computed properties, but they CAN NOT add stored properties.
// They CAN NOT add observers to existing properties either.

// Extensions can add new convenience initializers, but they can not add new designated initializers.
// You're responsible for making sure that each instance is fully initialized.

// nested types in extensions
extension Int {
    enum Kind {
        case Negative, Zero, Positive
    }
    
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x < 0:
            return .Negative
        default:
            return .Positive
        }
    }
}

//: PROTOCOLS

protocol FullyNamed {
    var fullName: String { get } // gettable property
    
    // settable property would be declared like this:
    // var fullName: String { get set }
}

struct Person2: FullyNamed {
    var firstName: String
    var lastName: String
    
    var fullName: String {
        return firstName + " " + lastName
    }
}

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

var nc1701 = Starship(name: "Enterprise", prefix: "USS")

protocol RandomNumberGenerator {
    func generate() -> Double
    
    // if you need to define a type method, use 'class' keyword
}

class Rand: RandomNumberGenerator {
    func generate() -> Double {
        return 0.0
    }
}

// Protocols can define initializers.
// When a class conforms to the protocol, it must implement the initializers.
// All implemented initializers must be marked with the 'required' keyword.

// Protocols can extend other protocols.
// The syntax is the same as for class extension.

// Protocol can be defined as class only protocol.
// This means that only classes can conform to this protocol.

protocol SomeClassOnlyProtocol: class {
    
}

// You can conform to a protocol from a class extension as well.
// If, for example, a class already implements all the requirements of a protocol,
// but it does not conform to the protocol, you can create an empty extension,
// which conforms to the protocol.

// It can be useful to require a type to conform to multiple protocols.
// This is called 'protocol composition'.
// The syntax is the following:
// var name: protocol<ProtocolA, ProtocolB>

// Use 'is', 'as', and 'as?' for protocol conformance.

// Protocols may have optional requirements.
// Optional requirements are prefixed by the 'optional' keyword.
// An optional protocol requirement can be called with optional chaining.
// To use optional requirements, the protocol must be marked with '@objc' attribute.
// @objc protocols can only be adopted to by clases.

@objc protocol CounterDataSource {
    optional func incrementForCount(count: Int) -> Int // optional method requirement
    optional var fixedIncrement: Int { get } // optional property requirement
}

class Counter2 {
    var count = 0
    var dataSource: CounterDataSource?
    
    func increment() {
        if let amount = dataSource?.incrementForCount?(count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

//: GENERICS

// Swift allows you to define generic functions and generic types.

// This is an example of a generic function.
// 'T' is a placeholder type.
//
func swapValues<T>(inout a: T, inout b: T) {
    let tmp = a
    a = b
    b = tmp
}

var a1 = 1, b1 = 2
// Swift automatically infers the type to use in place of T
swapValues(&a1, b: &b1)

// If a function or type has a single type parameter, it is traditionally named 'T'.
// However, for multiple type parameters, choose names that accurately describe their purpose.
// Always use UpperCamelCase to name type parameters.

// This is an example of a generic type.
struct Stack<T> {
    var items = [T]()
    
    mutating func push(item: T) {
        items.append(item)
    }
    
    mutating func pop() -> T {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("One")
stackOfStrings.pop()

// When you extend a generic type, you do not provide a type parameter list as part of the
// extension's definition.
// Type parameter list from the original type are available within the body of the extension.

extension Stack {
    var topItem: T? { // <-- this is a computed read-only property
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

// Type constraints.

func findIndex<T: Equatable>(array: [T], valueToFind: T) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    
    return nil
}

// Associated Types.

protocol Container {
    typealias ItemType // this is an associated type
    
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

// The protocol above does not specify a concrete type of items.
// Instead it uses a type alias to denote that the type must be specified at adoption time.
// When adopting this protocol, the class or structure must implement all the required methods
// and use a concrete type (such as Int or Double) in place of 'ItemType'.

// Where Clause.

// The functions type parameter list places the following constraints on the type parameters:
// - C1 and C2 must conform to the Container protocol. Written as 'C1: Container'.
// - ItemType for C1 must be the same as ItemType for C2. 'C1.ItemType == C2.ItemType'.
// - ItemType for C1 must confirm to the Equatable protocol. 'C1.ItemType: Equatable'.
//
func allMethodsMatch
    <C1: Container, C2: Container where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>
    (container: C1, anotherContainer: C2) -> Bool {
        if container.count != anotherContainer.count {
            return false
        }
        
        for i in 0..<container.count { // <-- half-open range operator
            if container[i] != anotherContainer[i] {
                return false
            }
        }
        
        return true
}

//: ACCESS CONTROL

// The default access level is internal.
// An internal entity can be used by other entities in the same app or framework,
// but not in a different app or framework.

// If you mark a class private, its members will be private by default.
// If you mark a class as internal, public, or don't mark it, its members will be internal by default.

public class SomePublicClass {
    public var somePublicProperty = 0
    var someInternalProperty = 0
    private func somePrivateMethod() {}
}

private class SomePrivateClass {
    var SomePrivateProperty = 0
    func somePrivateMethod() {}
}

// This function must be explicitly declared private, otherwise, it won't compile.
// The reason is that its return type is a private tuple.
// The access level for a tuple is the most restrictive level of all types in that tuple.
// In this case, the returned tuple has SomePrivateClass member, which is private.
// Therefore, in order to use this function, the client needs access to the private class,
// which is not possible.
// For this reason, the function must be declared private.
//
private func someFunc() -> (SomePublicClass, SomePrivateClass)? {
    return nil
}

// In an enumeration type, individual cases receive the same access as the enum they belong to.
// You can not specify an access level for individual cases.

// A subclass can override any class member that is visible in a certain context.

public class A {
    private func someMethod() {}
}

// Class B extends A and makes it more restrictive.
internal class B : A {
    // Class B overrides a private method in class A, and it makes it less restrictive.
    // The reason why it's possible is because class B is declared in the same source file as A,
    // so it can see private members of A.
    //
    override internal func someMethod() {
        super.someMethod()
    }
}

// A constant, variable, or property can not be more public than its type.

struct TrackedString {
    // The setter is only available to members defined in the same source file.
    // To everyone else, this property will appear as read-only.
    //
    private(set) var numberOfEdits = 0
    
    var value: String = "" {
        didSet {
            numberOfEdits++
        }
    }
}

//: ADVANCED OPERATORS*

// Bitwise operators: ~ (not), & (and), | (or), ^ (xor), << (left shift), >> (right shift).

// Overflow operators help deal with errors that occur when you you try to store a value,
// which is too large or too small for a given type.
// Instead of generating an error, overflow operators truncate the number of bits.
// &+, &-, &/, &*, &%

// Overflow example
var willOverflow = UInt8.max
willOverflow = willOverflow &+ 1
// willOverflow is 0 now

// Underflow example
var willUnderflow = UInt8.min
willUnderflow = willUnderflow &- 1
// willUnderflow is now 255

// Classes and structures can override existing operators.

struct Vector2D {
    var x = 0.0, y = 0.0
}

// The operator function is defined as a global function.
// The function names matches the name of the operator to be overloaded.
//
func + (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}

// Operators such as addition, substraction, division, and multiplication are known as binary operators.
// They require two operands.
// Since they appear in the middle, they are also called 'infix' operators.

// There are also unary operators, such as -, ++, --, etc.
// These operators could be prefix (-a) or postfix (a++).
// Write 'prefix' or 'postfix' modifier to implement a corresponding operator.

prefix func - (vector: Vector2D) -> Vector2D {
    return Vector2D(x: -vector.x, y: -vector.y)
}

// You can also override compound assignment operators (+=, /=, etc.)
// The left input parameter must be marked 'inout', since it will be modified directly.

func += (inout left: Vector2D, right: Vector2D) {
    // we take advantadge of an addition operator defined earlier for the Vector2D type
    left = left + right
}

// You can not override the default assignment operator (=) and ternary conditional operator ( ?:).

// Swift does not provide a default implementation for equivalence operator (==) for custom types.
// You need to provide such an operator yourself.

func == (left: Vector2D, right: Vector2D) -> Bool {
    return (left.x == right.x) && (left.y == right.y)
}

func != (left: Vector2D, right: Vector2D) -> Bool {
    return !(left == right)
}

// Swift allows you to define custom operators.
// For more details, consult the language guide: Advanced Operators -> Custom Operators.
