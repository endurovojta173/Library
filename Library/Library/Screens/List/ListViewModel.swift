//
//  ListViewModel.swift
//  Library
//
//  Created by endurovojta173 on 25.05.2026.
//

import SwiftUI

@Observable
class ListViewModel{
    var state: ListViewState = ListViewState()
    
    private var dataManager: DataManaging
    
    init() {
        dataManager = DIContainer.shared.resolve()
    }
    
    func fetchBooks(){
        state.books = dataManager.fetchBooks()
    }
    
    func remainingTime(book: Book) -> Int {
        // Pokud kniha nemá zápůjčku, vrátí 0 (případně si upravte podle potřeby)
        guard let dueDate = book.loan?.borrowedUntil else { return 0 }
        
        // Výpočet rozdílu ve dnech mezi dneškem a datem vrácení
        let components = Calendar.current.dateComponents([.day], from: Date(), to: dueDate)
        return components.day ?? 0
    }
    
}
