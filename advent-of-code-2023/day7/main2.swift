import Foundation

let path = "input.txt"

let input = try String(contentsOfFile: path, encoding: .utf8)

enum Card: Equatable, Comparable, CaseIterable {
    case n2, n3 ,n4, n5, n6, n7, n8, n9, T, J, Q, K, A
}

enum Combination: Equatable, Comparable, CaseIterable {
    case none, isHighCard, isOnePair, isTwoPairs, isThreeOfAKind, isFullHouse, isFourOfAKind, isFiveOfAKind
}

struct Person {
    let hand: [Card]
    let bid: Int
}

let people = input
    .split(whereSeparator: \.isNewline)
    .map { line in
        let data = line.split(separator: " ")
        let cards = data[0]
            .map { char in 
                switch char {
                    case "A":
                        Card.A
                    case "K":
                        Card.K
                    case "Q":
                        Card.Q
                    case "J":
                        Card.J
                    case "T":
                        Card.T
                    case "9":
                        Card.n9
                    case "8":
                        Card.n8
                    case "7":
                        Card.n7
                    case "6":
                        Card.n6
                    case "5":
                        Card.n5
                    case "4":
                        Card.n4
                    case "3":
                        Card.n3
                    case "2":
                        Card.n2
                    default:
                        fatalError()
                }
            }
        let bid = Int(String(data[1]))!
        return Person(hand: cards, bid: bid)
    }

let result = people
    .sorted(by: { $0.hand < $1.hand })
    .enumerated()
    // .map { ($0.offset + 1) * $0.element.bid }
    // .reduce(into: 0) { $0 += $1 }

for test in result {
    print("\(test) - \(Array<Card>.getScore(test.element.hand))")
}

let result2 = result
    .map { ($0.offset + 1) * $0.element.bid }
    .reduce(into: 0) { $0 += $1 }
print(result2)

 extension Array where Element == Card {
    static func < (lhs: Self, rhs: Self) -> Bool {
        let slhs = getScore(lhs)
        let srhs = getScore(rhs)
        if slhs != srhs {
            return slhs < srhs
        }
        for pair in zip(lhs, rhs) where pair.0 != pair.1 {
            if pair.0 == .J {
                return true
            } else if pair.1 == .J {
                return false
            }
            return pair.0 < pair.1
        }
        return false
    }

    static func getScore(_ cards: Self) -> Combination {
        guard cards.contains(.J) else {
            return getScore2(cards)
        }
        // I'm tired...
        return Card
        .allCases
        .filter({ $0 != .J})
        .map { replacement in getScore2(cards.map { if $0 == .J { replacement } else { $0 }})}
        .max()!
    }

    static func getScore2(_ cards: Self) -> Combination {
        if isFiveOfAKind(cards) {
            return .isFiveOfAKind
        } else if isFourOfAKind(cards) {
            return .isFourOfAKind
        } else if isFullHouse(cards) {
            return .isFullHouse
        } else if isThreeOfAKind(cards) {
            return .isThreeOfAKind
        } else if isTwoPairs(cards) {
            return .isTwoPairs
        } else if isOnePair(cards) {
            return .isOnePair
        } else if isHighCard(cards) {
            return .isHighCard
        } else {
            return .none
        }
    }

    static private func isFiveOfAKind(_ cards: Self) -> Bool {
        let set = Set(cards)
        return set.count == 1
    }

    static private func isFourOfAKind(_ cards: Self) -> Bool {
        let set = Set(cards)
        for uniqueCard in set {
            if cards.filter({ $0 == uniqueCard}).count == 4 {
                return true
            }
        }
        return false
    }

    static private func isFullHouse(_ cards: Self) -> Bool {
        let set = Set(cards)
        if set.count != 2 {
            return false
        }
       for uniqueCard in set {
        if cards.filter({ $0 == uniqueCard}).count == 3 {
            return true
        }
       }
       return false 
    }

    static private func isThreeOfAKind(_ cards: Self) -> Bool {
        let set = Set(cards)
        if set.count != 3 {
            return false
        }
       for uniqueCard in set {
        if cards.filter({ $0 == uniqueCard}).count == 3 {
            return true
        }
       }
       return false 
    }

    static private func isTwoPairs(_ cards: Self) -> Bool {
        let set = Set(cards)
       if set.count != 3 {
        return false
       }

        var numberOfPairs = 0

       for uniqueCard in set {
        if cards.filter({ $0 == uniqueCard}).count == 2 {
            numberOfPairs += 1
        }
       }
       return numberOfPairs == 2 
    }

    static private func isOnePair(_ cards: Self) -> Bool {
       let set = Set(cards)
       if set.count != 4 {
        return false
       }

       for uniqueCard in set {
        if cards.filter({ $0 == uniqueCard}).count == 2 {
            return true
        }
       }
       return false
    }

    static private func isHighCard(_ cards: Self) -> Bool {
        let set = Set(cards)
        return set.count == cards.count
    }
}