//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Clay on 12/29/21.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    
  
    }
    

