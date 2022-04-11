//
//  ContentView.swift
//  iExpense
//
//  Created by Clay on 12/17/21.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                                .font(.headline)
                              
                        }
                        
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            .foregroundColor(
                                item.amount <= 10 ? .green :
                                    item.amount >= 100 ? .red : nil
                           
                            )
                    }
                    
                }
                .onDelete(perform: removeItems)
                .onMove(perform: moveItems)
                
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                   showingAddExpense = true
                }label: {
                    Image(systemName: "plus")
                }
                
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
            
        }
        
    }

    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
        
    }
    
    func moveItems(from source: IndexSet, to dest: Int) {
        expenses.items.move(fromOffsets: source, toOffset: dest)
    }
    
    func getColor(expenseAmount: Int) -> Color {
        if expenseAmount <= 10 {
            return Color.yellow
        }else if expenseAmount <= 100 {
            return Color.orange
        }
        return Color.red
    
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
