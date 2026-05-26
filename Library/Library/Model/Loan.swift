//
//  Loan.swift
//  Library
//
//  Created by endurovojta173 on 25.05.2026.
//

import SwiftUI

struct Loan: Identifiable{
    var id: UUID = UUID()
    var borrowerName: String
    var borrowed: Date
    var borrowedUntil: Date
    
   /* static func getSample()->Loan{
        .init(
            
            borrowerName: "Jan Novak",
            borrowed: hardcodedDate,
            borrowedUntil: Date)
    }*/
}
