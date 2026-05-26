//
//  AddLoanViewState.swift
//  Library
//
//  Created by endurovojta173 on 25.05.2026.
//


import SwiftUI

@Observable
class AddLoanViewState{
    var books: [Book] = []
    var selectedBook: Book = .getSample()
}
