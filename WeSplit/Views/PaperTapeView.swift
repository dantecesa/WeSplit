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
                NavigationLink(destination: {
                    PaperTapeItemView(currentPaperTapeItem: item)
                }, label: {
                    
                    HStack {
                        VStack (alignment: .leading) {
                            Text(item.name)
                            Text("\(item.dateTime, style: .date)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Text("\(item.totalWithTip, format: .currency(code: Locale.current.currencyCode ?? "USD"))")
                    }
                })
            }.onDelete(perform: removeItems)
        }.navigationTitle("Paper Tape")
            .toolbar {
                EditButton()
            }
        if paperTape.items.count > 0 {
            Button("Remove All") {
                paperTape.items.removeAll()
            }
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
