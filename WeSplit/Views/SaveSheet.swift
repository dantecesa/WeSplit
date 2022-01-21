//
//  SaveSheet.swift
//  WeSplit
//
//  Created by Dante Cesa on 1/21/22.
//

import SwiftUI

struct SaveSheet: View {
    @State var name: String = ""
    @Environment(\.dismiss) var dismiss
    @State var itemToSave: PaperTapeItem
    let paperTape: PaperTape
    
    var body: some View {
        VStack {
            TextField("I'm a text", text: $name)
            Button("Save") {
                itemToSave.name = name
                paperTape.items.insert(itemToSave, at: 0)
                dismiss()
            }.disabled(name.count < 1)
        }
    }
}

struct SaveSheet_Previews: PreviewProvider {
    static var previews: some View {
        SaveSheet(itemToSave: PaperTapeItem(name: "Test", checkAmount: 5.0, numberOfPeople: 5, tipPercentage: 20, includeTax: true, taxAmount: 9.75, totalWithTip: 150, totalPerPerson: 30, dateTime: Date.now), paperTape: PaperTape())
    }
}
