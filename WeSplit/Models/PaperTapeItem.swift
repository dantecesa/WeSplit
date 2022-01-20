//
//  PaperTapeItem.swift
//  WeSplit
//
//  Created by Dante Cesa on 1/19/22.
//

import Foundation

struct PaperTapeItem: Identifiable, Codable {
    var id: UUID = UUID()
    let amount: Double
    let dateTime: Date
}
