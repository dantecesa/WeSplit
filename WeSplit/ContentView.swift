//
//  ContentView.swift
//  WeSplit
//
//  Created by Dante Cesa on 1/4/22.
//

import SwiftUI

struct ContentView: View {
    let tipPercentages: [Int] = [0, 10, 15, 20, 25]
    let maxNumberOfPeople: Int = 10
    @State var checkAmount: Double? = nil
    @State var numberOfPeople: Int = 0
    @State var tipPercentage: Int = 15
    @FocusState private var amountIsFocused: Bool
    @State var brettIsPresent: Bool = false
    
    var totalWithTip: Double? {
        if let checkAmount = checkAmount {
            return checkAmount + (checkAmount * (Double(tipPercentage)/100))
        } else {
            return nil
        }
    }
    
    var totalPerPerson: Double? {
        let peopleCount: Double
        
        if brettIsPresent {
            peopleCount = Double(numberOfPeople + 1)
        } else {
            peopleCount = Double(numberOfPeople + 2)
        }
        
        if let totalWithTip = totalWithTip {
            return totalWithTip/Double(peopleCount)
        } else {
            return nil
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD")).keyboardType(.decimalPad).focused($amountIsFocused)
                } header: {
                    Text("Tell me about the check…")
                }
                Section {
                    Picker("Split by…", selection: $numberOfPeople) {
                        ForEach(2..<maxNumberOfPeople) { index in
                            Text("\(index)")
                        }
                    }.pickerStyle(.segmented)
                    Toggle("Is Brett present?", isOn: $brettIsPresent)
                } header: {
                    Text("How many people?")
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("How much tip are we leaving?")
                }

                Section {
                    Text(totalWithTip ?? 0.00, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Total with Tip")
                }
                Section {
                    Text(totalPerPerson ?? 0.00, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Total per Person")
                }
            }.navigationTitle("WeSplit").toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
