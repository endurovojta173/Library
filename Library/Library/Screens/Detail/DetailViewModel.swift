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
    
    //Preda knihu z listu do detail statu
    init(book: Book){
        self.state = DetailViewState(book: book)
    }
    
    func returnBook() -> Book{
        return state.book
    }
}
