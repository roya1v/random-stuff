//
//  NetflixCharts.swift
//  IosUiPlaygoround
//
//  Created by Mike S. on 16/02/2025.
//

import SwiftUI
import Charts
import TabularData

struct NetflixCharts: View {

    let data = NetflixData()

    @State
    var countries = [String]()

    @State
    var numbers = [(String, Int)]()


    var body: some View {
        ScrollView(.horizontal) {
            Chart {
                ForEach(numbers, id: \.0) { shape in
                    BarMark(
                        x: .value("Shape Type", shape.0),
                        y: .value("Total Count", shape.1)
                    )
                }
            }
            .frame(width: 8100.0)
        }
            .task {
                var result = [String: Int]()
                for row in data.dataFrame.rows {
                    guard let country = row[5] as? String else {
                        continue
                    }
                    let countries = country.split(separator: ",")
                    for singleCountry in countries {
                        let test = String(singleCountry).trimmingCharacters(in: .whitespacesAndNewlines)
                        if let number = result[test] {
                            result[test] = number + 1
                        } else {
                            result[test] = 1
                        }
                    }
                }
                for (key, value) in result {
                    numbers.append((key, value))
                }
            }
    }
}

#Preview {
    NetflixCharts()
}
