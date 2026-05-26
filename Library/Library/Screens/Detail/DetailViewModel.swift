//
//  DetailViewModel.swift
//  Library
//
//  Created by endurovojta173 on 25.05.2026.
//

import SwiftUI

@Observable
class DetailViewModel{
    var state: DetailViewState
    
    
    private var dataManager: DataManaging

    //Preda knihu z listu do detail statu
    init(book: Book){
        self.state = DetailViewState(book: book)
        dataManager = DIContainer.shared.resolve()
    }
    
    func returnBook() -> Book{
        return state.book
    }
    
    func freeBook() {
        state.book =  dataManager.freeBook(state.book)
        }
}
