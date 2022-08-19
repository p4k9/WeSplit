//
//  ContentView.swift
//  WeSplit
//
//  Created by Paul Kenjerski on 8/15/22.
//

import SwiftUI
    
struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var number_ofPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool

    
    
    let tipPercentages  = [0,10,20,30,40,50]
    
    var amountPerPerson: Double {
        let peopleCount = Double(number_ofPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var totalBill: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    let localCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")

    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Check amount", value: $checkAmount, format: localCurrency)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("How many people?", selection: $number_ofPeople) {
                        ForEach(2..<100) {
                            Text("\($0) People")
                        }
                    }
                } header: {
                Text("How much is the check?")
                }
                
                Section {
                    Picker ("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                            
                        }
                    } .pickerStyle(.segmented)
                    
                } header: {
                    Text("How much tip do you want to leave?")
                    }
                
                
                Section {
                    Text(totalBill, format: localCurrency)
                } header: {
                    Text("Total amount of check")
                    }
                
                
                
                Section {
                    Text(amountPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Amount per person")
                    }
                
            }   .navigationTitle("WeSplit")
                .toolbar {
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
