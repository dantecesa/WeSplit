//
//  PaperTape.swift
//  WeSplit
//
//  Created by Dante Cesa on 1/19/22.
//

import Foundation
import SwiftUI

class PaperTape: ObservableObject {
    @Published var items: [PaperTapeItem] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "items") {
            if let decodedItems = try? JSONDecoder().decode([PaperTapeItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
    }
}
