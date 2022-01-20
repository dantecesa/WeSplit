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
    @AppStorage("checkAmount") var checkAmount: Double?
    @AppStorage("numberOfPeople") var numberOfPeople: Int = 0
    @AppStorage("tipPercentage") var tipPercentage: Int = 15
    @FocusState private var numberFieldIsFocused: Bool
    @AppStorage("calculateTipBeforeTax") var calculateTipBeforeTax: Bool = false
    @State var taxPercentage: Double = 0.0985
    
    var totalWithTip: Double? {
        guard let checkAmount = checkAmount else {
            return nil
        }
        
        if calculateTipBeforeTax {
            return checkAmount + (checkAmount - (checkAmount * taxPercentage)) * Double(tipPercentage)/100
        } else {
            return checkAmount + (checkAmount * (Double(tipPercentage)/100))
        }
    }
    
    var totalPerPerson: Double? {
        let peopleCount = Double(numberOfPeople + 2)
        
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
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD")).keyboardType(.decimalPad).focused($numberFieldIsFocused)
                } header: {
                    Text("Tell me about the check…")
                }
                Section {
                    Picker("Split by…", selection: $numberOfPeople) {
                        ForEach(2..<maxNumberOfPeople) { index in
                            Text("\(index)")
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("How many people?")
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                    Toggle("Exclude tax?", isOn: $calculateTipBeforeTax.animation())
                    if calculateTipBeforeTax {
                        HStack {
                            Text("Tax Amount")
                            Spacer()
                            TextField("Tax", value: $taxPercentage, format: .percent).keyboardType(.decimalPad).focused($numberFieldIsFocused).multilineTextAlignment(.trailing)
                        }
                    }
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
                        numberFieldIsFocused = false
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
