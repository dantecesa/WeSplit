//
//  PaperTapeItem.swift
//  WeSplit
//
//  Created by Dante Cesa on 1/19/22.
//

import Foundation

struct PaperTapeItem: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    let checkAmount: Double
    let numberOfPeople: Int
    let tipPercentage: Int
    let includeTax: Bool
    let taxAmount: Double
    let totalWithTip: Double
    let totalPerPerson: Double
    let dateTime: Date
}
