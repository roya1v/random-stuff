import swiftCopyWith

enum Gender {
    case male, female, other
}

@CopyWith()
struct Animal {
    let name: String
    let age: Int
    let gender: Gender
}

let test = Animal(name: "ghe", age: 3, gender: .female)

let test2 = test.copyWith(name: "Hello")
