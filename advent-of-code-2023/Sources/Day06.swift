//
//  Day06.swift
//
//
//  Created by Mike S. on 10/12/2023.
//

import Foundation

struct Day06: AdventDay {

    var data: String

    func part1() -> Any {
        let times = data
            .split(whereSeparator: \.isNewline)[0]
            .split(whereSeparator: { !$0.isNumber})

        let distances = data
            .split(whereSeparator: \.isNewline)[1]
            .split(whereSeparator: { !$0.isNumber})

        let races = zip(times, distances)

        return races.map { math(t: Double($0.0)!, d: Double($0.1)!)}.reduce(1, *)
    }

    func math(t: Double, d: Double) -> Int {
        let x1 = (-t - sqrt(t * t - 4 * d)) / -2
        let x2 = (-t + sqrt(t * t - 4 * d)) / -2
        return Int(floor(max(x1, x2))-ceil(min(x1, x2))) + 1
    }

    func part2() -> Any {
        var cleanInput = data
        cleanInput.removeAll(where: { ($0.isWhitespace || $0.isLetter || $0 == ":") && !$0.isNewline})

        let times2 = cleanInput
            .split(whereSeparator: \.isNewline)[0]

        let distances2 = cleanInput
            .split(whereSeparator: \.isNewline)[1]

        return  math(t: Double(String(times2))!, d: Double(String(distances2))!)
    }
}
