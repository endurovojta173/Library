//
//  Book.swift
//  Library
//
//  Created by endurovojta173 on 25.05.2026.
//
import SwiftUI

struct Book: Identifiable{
    var id: UUID = UUID()
    var title: String
    var genre: Genre
    var author: String
    //Optional loan of book
    var loan: Loan?
    
    static func getSample() -> Book {
        .init(
            title: "Hobit1",
            genre: .novel,
            author: "Tolkien",
            loan: Loan(
                        borrowerName: "Pepa z Kralic",
                        borrowed: Date(),
                        borrowedUntil: Calendar.current.date(byAdding: .day, value: 14, to: Date())!
                    )
        )
    }
    static func getSample2() -> Book {
        .init(
            title: "Hobit2",
            genre: .novel,
            author: "Tolkien",
            loan: Loan(
                        borrowerName: "Pepa z Kralic",
                        borrowed: Date(),
                        borrowedUntil: Calendar.current.date(byAdding: .day, value: -6, to: Date())!
                    )
        )
    }
    static func getSampleWithoutLoan() -> Book {
        .init(
            title: "Hobit3",
            genre: .novel,
            author: "Tolkien",
        )
    }
    static func getSamples() -> [Book] {
        var books: [Book] = []
        books.append(getSample())
        books.append(getSampleWithoutLoan())
        books.append(getSample2())
        return books
    }
}


//CaseIterable - vygeneruje .allCases
//Int16 - umozni pridat cislo k enumu
enum Genre: String {
    case novel = "Novel"
    case textbook = "Textbook"
    case magazine = "magazine"
}
