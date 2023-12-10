//
//  Day02.swift
//
//
//  Created by Mike S. on 10/12/2023.
//

import Foundation

struct Day02: AdventDay {

    var data: String

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

    var entities: [[Game]] {
        data.split(whereSeparator: \.isNewline)
            .map { game in
                game.split(separator: ": ")[1]
                    .split(separator: "; ")
                    .map { Game(string: String($0))}
            }
    }

    func part1() -> Any {
        entities
            .enumerated()
            .filter { games in
                games.element.map { game in
                    game.blueCubes <= blueCubes && game.greenCubes <= greenCubes && game.redCubes <= redCubes
                }
                .reduce(into: true) { $0 = $0 && $1 }
            }
            .reduce(into: 0) {
                $0 += $1.offset + 1
            }
    }

    func part2() -> Any {
        entities
            .map { games in
                Game(red: games.map(\.redCubes).max()!,
                     greenCubes: games.map(\.greenCubes).max()!,
                     blueCubes: games.map(\.blueCubes).max()!)
            }
            .reduce(into: 0) {
                $0 += $1.blueCubes * $1.redCubes * $1.greenCubes
            }
    }
}
