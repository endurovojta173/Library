//
//  MockDataManager.swift
//  Library
//
//  Created by endurovojta173 on 25.05.2026.
//
import SwiftUI
import CoreData

final class MockDataManager: DataManaging{
    private var books: [Book] = Book.getSamples()
    
    func fetchBooks() -> [Book]{
        return books
    }
    
    // 2. Uložení nové výpůjčky
        func addLoan(to book: Book, readerName: String, dueDate: Date) {
            // Najdeme index knihy v lokálním poli podle ID
            if let index = books.firstIndex(where: { $0.id == book.id }) {
                
                // Vytvoříme novou zápůjčku
                let newLoan = Loan(
                    borrowerName: readerName,
                    borrowed: Date(),
                    borrowedUntil: dueDate
                )
                
                // Nahradíme knihu v poli její aktualizovanou verzí
                let existingBook = books[index]
                books[index] = Book(
                    id: existingBook.id,
                    title: existingBook.title,
                    genre: existingBook.genre,
                    author: existingBook.author,
                    loan: newLoan
                )
            }
        }
        
        // 3. Vrácení knihy (načtení detailu s loanem z paměti)
        func returnBook(_ book: Book) -> Book {
            // Vyhledá a vrátí knihu z pole, pokud existuje. Jinak vrátí původní.
            if let foundBook = books.first(where: { $0.id == book.id }) {
                return foundBook
            }
            return book
        }
    
    func freeBook(_ book: Book)->Book{
        if let index = books.firstIndex(where: { $0.id == book.id }) {
            books[index].loan = nil
            return books[index]
        }
        return .getSample()
    }
}

