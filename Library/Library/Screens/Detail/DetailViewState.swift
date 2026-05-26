//
//  DetailViewState.swift
//  Library
//
//  Created by endurovojta173 on 25.05.2026.
//

import SwiftUI

@Observable
class DetailViewState{
    var book: Book
    
    //Umozni predani realne knihy
    init(book: Book) {
        self.book = book
    }
}
