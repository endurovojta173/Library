//
//  DataManaging.swift
//  Library
//
//  Created by endurovojta173 on 25.05.2026.
//

import Foundation

protocol DataManaging{
    // 1. Získání dat pro View seznamu
        func fetchBooks() -> [Book]
        
        // 2. Uložení nové výpůjčky (z modálního okna Add Loan)
        func addLoan(to book: Book, readerName: String, dueDate: Date)
        
        // 3. Vrácení knihy (tlačítko Returned v detailu)
        func returnBook(_ book: Book) -> Book
    
    //Meni taken stav
    func freeBook(_ book: Book)->Book
}
