//
//  NetflixData.swift
//  IosUiPlaygoround
//
//  Created by Mike S. on 16/02/2025.
//

import Foundation
import TabularData

// Data from https://www.kaggle.com/datasets/anandshaw2001/netflix-movies-and-tv-shows
struct NetflixData {

    let dataFrame: DataFrame

    init() {
        guard let url = Bundle.main.url(forResource: "netflix_titles", withExtension: "csv"),
              let dataFrame = try? DataFrame(csvData: Data(contentsOf: url)) else {
            fatalError("Couldn't load netflix_titles.csv")
        }

        self.dataFrame = dataFrame
    }
}
