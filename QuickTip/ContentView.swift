//
//  ContentView.swift
//  QuickTip
//
//  Created by Mark Zhou on 1/8/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    @State var roundCost = true
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 1)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0

        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var totalPerPersonRounded: Double {
        let amountPerPersonRounded = totalPerPerson.rounded()
        
        return amountPerPersonRounded
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("How much are you paying in total?")) {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)

                        Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(1 ..< 100) {
                                Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
                Section(header: Text("Would you like to round the cost?")) {
                    VStack {
                       Toggle(isOn: $roundCost) {
                           Text("Round to nearest dollar")
                       }
                    }
                }
                
                Section(header: Text("Final cost/person:")) {
                    if roundCost {
                        Text("$\(totalPerPersonRounded)")
                    } else {
                        Text("$\(totalPerPerson)")
                    }
                    
                }
            }
            .navigationBarTitle("QuickTip")
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
