//
//  PaperTapeItemView.swift
//  WeSplit
//
//  Created by Dante Cesa on 1/21/22.
//

import SwiftUI

struct PaperTapeItemView: View {
    let currentPaperTapeItem: PaperTapeItem
    let tipPercentages: [Int] = [0, 10, 15, 20, 25]
    
    var body: some View {
        Form {
            Section {
                Text(currentPaperTapeItem.checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
            } header: {
                Text("Tell me about the check…")
            }
            Section {
                Text("\(currentPaperTapeItem.numberOfPeople)")
            } header: {
                Text("How many people?")
            }
            
            Section {
                HStack {
                    Text("Tip Percentage")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(currentPaperTapeItem.tipPercentage, format: .percent)
                }
                if currentPaperTapeItem.includeTax {
                    HStack {
                        Text("Tax Amount")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(currentPaperTapeItem.taxAmount, format: .percent)
                    }
                }
            } header: {
                Text("How much tip did we leave?")
            }
            
            Section {
                HStack {
                    Text("… with tip")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(currentPaperTapeItem.totalWithTip, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }
                HStack {
                    Text("… per person")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(currentPaperTapeItem.totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }
            } header: {
                Text("Total")
            }
        }.navigationTitle(currentPaperTapeItem.name)
    }
}

struct PaperTapeItemView_Previews: PreviewProvider {
    static var previews: some View {
        PaperTapeItemView(currentPaperTapeItem: PaperTapeItem(name: "Test Papertape", checkAmount: 100, numberOfPeople: 5, tipPercentage: 15, includeTax: false, taxAmount: 9.85, totalWithTip: 100, totalPerPerson: 50, dateTime: Date.now))
    }
}
