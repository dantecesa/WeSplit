//
//  PaperTapeView.swift
//  WeSplit
//
//  Created by Dante Cesa on 1/19/22.
//

import SwiftUI

struct PaperTapeView: View {
    @ObservedObject var paperTape: PaperTape
    
    var body: some View {
        List {
            ForEach(paperTape.items) { item in
                HStack {
                    Text("\(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))")
                    Spacer()
                    Text("\(item.dateTime, style: .date)")
                        .foregroundColor(.secondary)
                }
            }.onDelete(perform: removeItems)
        }
        .navigationTitle("Paper Tape")
        .toolbar {
            EditButton()
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        paperTape.items.remove(atOffsets: offsets)
    }
}

struct PaperTapeView_Previews: PreviewProvider {
    static var previews: some View {
        PaperTapeView(paperTape: PaperTape())
    }
}
