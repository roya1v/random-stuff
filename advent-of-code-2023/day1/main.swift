import Foundation

let path = "input.txt"

let contents = try String(contentsOfFile: path, encoding: .utf8)

var result = 0

for line in contents.split(whereSeparator: \.isNewline) {
    var firstNumber: Int? = nil
    var lastNumber: Int? = nil
    for character in line where character.isNumber {
        if firstNumber != nil {
            lastNumber = Int(String(character))
        } else {
            firstNumber = Int(String(character))
        }
    }
    result += (firstNumber ?? lastNumber ?? 0) * 10 + (lastNumber ?? firstNumber ?? 0)
}

print(result)

result = 0

let numbers = [
    "one": 1, "two": 2, "three": 3, "four": 4, "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9
]

// Definitely not the most elegant solution...
for line in contents.split(whereSeparator: \.isNewline) {
    var firstNumber: Int? = nil
    var lastNumber: Int? = nil

    var workingLine = line

    while(!workingLine.isEmpty) {
        if workingLine.first!.isNumber {
            if firstNumber != nil {
                lastNumber = Int(String(workingLine.first!))
            } else {
                firstNumber = Int(String(workingLine.first!))
            }
        } else {
            for (key, value) in numbers {
                if workingLine.hasPrefix(key) {
                    if firstNumber != nil {
                        lastNumber = value
                    } else {
                        firstNumber = value
                    }
                    break
                }
            }
        }
        workingLine = workingLine.dropFirst()
    }
    result += (firstNumber ?? lastNumber ?? 0) * 10 + (lastNumber ?? firstNumber ?? 0)
}

print(result)
