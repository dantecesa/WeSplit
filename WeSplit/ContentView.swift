//
//  ContentView.swift
//  WeSplit
//
//  Created by Dante Cesa on 1/4/22.
//

import SwiftUI

struct ContentView: View {
    var iterations: Int = 15
    @State var tapCounter: Int = 0
    
    var body: some View {
        NavigationView {
        VStack {
            Text("Counter is \(tapCounter)")
            Button(
                action: {
                   tapCounter += 1
                }, label: {Text("Tap me!")})
            
            Form {
                Section {
                ForEach(0..<iterations) { index in
                    Text("Hello, world & \(index)")
                }
                }
                Section {
                    ForEach(0..<4) { index in
                        Text("Hi, I'm button \(index) in a section")
                    }
                }
            }
        }.navigationTitle(Text("Swift UI Demo"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
