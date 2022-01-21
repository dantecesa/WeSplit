//
//  ContentView.swift
//  WeSplit
//
//  Created by Dante Cesa on 1/4/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("checkAmount") var checkAmount: Double?
    
    let maxNumberOfPeople: Int = 10
    @AppStorage("numberOfPeople") var numberOfPeople: Int = 0
    
    let tipPercentages: [Int] = [0, 10, 15, 20, 25]
    @AppStorage("tipPercentage") var tipPercentage: Int = 15
    
    @AppStorage("calculateTipBeforeTax") var calculateTipBeforeTax: Bool = false
    @State var taxPercentage: Double = 0.0985
    
    @FocusState private var numberFieldIsFocused: Bool
    var paperTape = PaperTape()
    
    @State var showSaveSheet: Bool = false
    
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
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($numberFieldIsFocused)
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
                    HStack {
                        Text(totalWithTip ?? 0.00, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        Spacer()
                        Button("Save") {
                            showSaveSheet = true
                        }
                    }
                } header: {
                    Text("Total with Tip")
                }
                Section {
                    Text(totalPerPerson ?? 0.00, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Total per Person")
                }
            }.navigationTitle("WeSplit")
                .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        numberFieldIsFocused = false
                    }
                }
                    ToolbarItemGroup(
                        placement: .navigationBarTrailing,
                        content: {
                            NavigationLink("Paper Tape") {
                                PaperTapeView(paperTape: paperTape)
                            }
                        }
                    )
                }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $showSaveSheet) {
            let itemToSave: PaperTapeItem = PaperTapeItem(name: "", checkAmount: checkAmount ?? 0, numberOfPeople: numberOfPeople, tipPercentage: tipPercentage, includeTax: calculateTipBeforeTax, taxAmount: taxPercentage, totalWithTip: totalWithTip ?? 0, totalPerPerson: totalPerPerson ?? 0, dateTime: Date.now)
            
            SaveSheet(itemToSave: itemToSave, paperTape: paperTape)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
