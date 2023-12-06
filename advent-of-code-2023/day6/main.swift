import Foundation

let path = "input.txt"

let input = try String(contentsOfFile: path, encoding: .utf8)

let times = input
        .split(whereSeparator: \.isNewline)[0]
        .split(whereSeparator: { !$0.isNumber})

let distances = input
        .split(whereSeparator: \.isNewline)[1]
        .split(whereSeparator: { !$0.isNumber})

let races = zip(times, distances)

let result1 = races.map { math(t: Double($0.0)!, d: Double($0.1)!)}.reduce(1, *)

print(result1)


func math(t: Double, d: Double) -> Int {
    let x1 = (-t - sqrt(t * t - 4 * d)) / -2
    let x2 = (-t + sqrt(t * t - 4 * d)) / -2
    return Int(floor(max(x1, x2))-ceil(min(x1, x2))) + 1
}

var cleanInput = input
cleanInput.removeAll(where: { ($0.isWhitespace || $0.isLetter || $0 == ":") && !$0.isNewline})

let times2 = cleanInput
        .split(whereSeparator: \.isNewline)[0]

let distances2 = cleanInput
        .split(whereSeparator: \.isNewline)[1]

let result2 = math(t: Double(String(times2))!, d: Double(String(distances2))!)

print(result2)
