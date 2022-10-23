import Cocoa

// checkpoint 1
let celcius = 38.0
let farenheit = (celcius * 9 / 5) + 32

//print("A temperature of \(celcius)°C = \(farenheit)°F")


// checkpoint 2
let arr = ["one", "two", "three", "two"]
//print("The array has \(arr.count) items of which \(Set(arr).count) are unique")


// checkpoint 3
func fizzBuzz() {
    for i in 1...100 {
        if i.isMultiple(of: 15) {
            print("FizzBuzz")
        } else if i.isMultiple(of: 3) {
            print("Fizz")
        } else if i.isMultiple(of: 5){
            print("Buzz")
        } else {
            print("\(i)")
        }
    }
}
//fizzBuzz()



func printTimesTables(for number: Int, end: Int = 12) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}
//printTimesTables(for: 5)



enum PasswordError: Error {
    case short, obvious
}

func checkPassword(_ password: String) throws -> String {
    if password.count < 5 { throw PasswordError.short }
    if password == "12345" { throw PasswordError.obvious }
    
    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}

let string = "12345"

do {
    let result = try checkPassword(string)
    print("Password rating: \(result)")
} catch PasswordError.short {
    print("Too short!")
} catch PasswordError.obvious {
    print("I have the same combination on my luggage!")
} catch {
    print("There was an error: \(error.localizedDescription)")
}




// checkpoint 4
enum SqrtError: Error {
    case outOfBounds, noRoot
}

func root(of n: Int) throws -> Int {
    if n < 1 || n > 10_000 {
        throw SqrtError.outOfBounds
    }
    
    for i in 1...10_000 {
        if n == i * i {
            return i
        }
    }
    
    throw SqrtError.noRoot
}

do {
    let n = 64
    let r = try root(of: n)
    print("The square root of \(n) is \(r)")
} catch SqrtError.outOfBounds {
    print("Out of bounds!")
} catch SqrtError.noRoot {
    print("Root could not be found in this stupid program")
}


// checkpoint 5
func checkpoint5() {
    let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]
    luckyNumbers.filter { !$0.isMultiple(of: 2) }
        .sorted { $0 < $1 }
        .map { "\($0) is a lucky number" }
        .forEach { print($0) }
}
//checkpoint5()

//struct Employee {
//    let name: String
//    var vacationAllocated = 14
//    var vacationTaken = 0
//
//    var vacationRemaining: Int {
//        get {
//            vacationAllocated - vacationTaken
//        }
//
//        set {
//            vacationAllocated = vacationTaken + newValue
//        }
//    }
//}
//
//var archer = Employee(name: "Sterling Archer")
//archer.vacationTaken += 4
//archer.vacationRemaining = 5
//print("Vaction remaining = \(archer.vacationRemaining)")



//struct Game {
//    var score = 0 {
//        willSet {
//            print("The ols score is \(score) and we will become \(newValue)")
//        }
//        didSet {
//            print("The score is now \(score), before it was \(oldValue)")
//        }
//    }
//}

//
//var game = Game()
//game.score += 10
//game.score -= 3
//game.score += 1

// checkpoint 6
struct Car {
    let model: String
    let seats: Int
    let maxGear: Int
    
    private var gear: Int
    
    init(model: String, seats: Int, maxGear: Int = 5) {
        self.model = model
        self.seats = seats
        self.maxGear = maxGear
        self.gear = 0
    }
    
    mutating func gearUp() {
        if gear < maxGear {
            gear += 1
        } else {
            print("Log: Can't select higher gear: already at highest gear")
        }
    }
    
    mutating func gearDown() {
        if gear > 0 {
            gear -= 1
        } else {
            print("Log: Can't gear down, already in neutral")
        }
    }
    
    func currentGear() {
        print("Current gear is \(gear)")
    }
}


// checkpoint 7
class Animal {
    let legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    func speak() {
        print("Woof!")
    }
}

class Cat: Animal {
    let isTame: Bool
    
    init(legs: Int, isTame: Bool) {
        self.isTame = isTame
        super.init(legs: legs)
    }
    
    func speak() {
        print("Meaow!")
    }
    
    func isTameKitty() {
        let tame = isTame ? " " : " not "
        print("I am\(tame)tame!")
    }
}

final class Corgi: Dog {
    override func speak() {
        print("Everyone loves me, even the queen. Woof!")
    }
}

final class Poodle: Dog {
    override func speak() {
        print("Woofity poofity")
    }
}

final class Persian: Cat {
    override func speak() {
        print("I'm really fluffy")
    }
}

final class Lion: Cat {
    override func speak() {
        print("One of these is not like the others...")
    }
}

let corgi = Corgi(legs: 4)
let poodle = Poodle(legs: 4)
let persian = Persian(legs: 4, isTame: true)
let lion = Lion(legs: 4, isTame: false)

corgi.speak()
poodle.speak()
persian.speak()
persian.isTameKitty()
lion.speak()
lion.isTameKitty()


protocol Vehicle {
    func estimateTime(for distance: Int) -> Double
    func travel(distance: Int)
}


struct Car3: Vehicle {
    func estimateTime(for distance: Int) -> Double {
        Double(distance) / 60
    }
    
    func travel(distance: Int) {
        print("travelling! this should take aruond \(estimateTime(for: distance)) hours")
    }
}

let car = Car3()
car.travel(distance: 100)


// checkpoint 8
protocol Building {
    var rooms: Int { get }
    var cost: Int { get set }
    var agent: String { get set }
    
    func printSummary()
}

extension Building {
    func printSummary() {
        print("This property has \(rooms) rooms and costs \(cost). The estate agent is \(agent).")
    }
}

struct House: Building {
    let rooms: Int
    var cost: Int
    var agent: String
    let pool: Bool
    
    func hasPool() {
        if pool {
            print("This house has a pool!")
        } else {
            print("Unfortunately this house does not have a pool")
        }
    }
}

struct Office: Building {
    let rooms: Int
    var cost: Int
    var agent: String
}

let house = House(rooms: 3, cost: 350_000, agent: "House Agent", pool: true)
let office = Office(rooms: 18, cost: 1_000_000, agent: "Office Buildings Inc")

house.printSummary()
house.hasPool()

office.printSummary()

let n: String? = "full"

func check(n: String?) {
    guard let ne = n else {
        print("empty")
        return
    }
    print(ne)
}
check(n: n)


// checkpoint 9
func randomInt(arr: [Int]?) -> Int {
    arr?.randomElement() ?? Int.random(in: 1...100)
}

let i = randomInt(arr: [31,32,34,35,36])
print(i)
