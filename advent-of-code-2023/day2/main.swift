import Foundation

let path = "input.txt"

let input = try String(contentsOfFile: path, encoding: .utf8)

let redCubes = 12
let greenCubes = 13
let blueCubes = 14

// Replace with tuple?
struct Game {
    var redCubes: Int = 0
    var greenCubes: Int = 0
    var blueCubes: Int = 0

    init(string: String) {
        for color in string.split(separator: ", ") {
            if color.hasSuffix(" red") {
                redCubes = Int(String(color.dropLast(" red".count)))!
            } else if color.hasSuffix(" blue") {
                blueCubes = Int(String(color.dropLast(" blue".count)))!
            } else if color.hasSuffix(" green") {
                greenCubes = Int(String(color.dropLast(" green".count)))!
            }
        }
    }

    init(red: Int, greenCubes: Int, blueCubes: Int) {
        self.redCubes = red
        self.greenCubes = greenCubes
        self.blueCubes = blueCubes
    }
}

let games = input
    .split(whereSeparator: \.isNewline)
    .map { game in
        game.split(separator: ": ")[1]
            .split(separator: "; ")
            .map { Game(string: String($0))}
    }
    .enumerated()

let part1 = games
    .filter { games in
        games.element.map { game in
                game.blueCubes <= blueCubes && game.greenCubes <= greenCubes && game.redCubes <= redCubes
            }
            .reduce(into: true) { $0 = $0 && $1 }
    }
    .reduce(into: 0) {
        $0 += $1.offset + 1
    }


for game in games {
    print("\(game.offset): \(game.element)")
}

print("part1: \(part1)")

let part2 = games
    .map(\.element)
    .map { games in
        Game(red: games.map(\.redCubes).max()!,
             greenCubes: games.map(\.greenCubes).max()!,
             blueCubes: games.map(\.blueCubes).max()!)
    }
    .reduce(into: 0) {
        $0 += $1.blueCubes * $1.redCubes * $1.greenCubes
    }

print("part2: \(part2)")