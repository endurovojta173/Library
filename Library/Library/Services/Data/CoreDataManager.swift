//
//  CoreDataManager.swift
//  Library
//
//  Created by endurovojta173 on 25.05.2026.
//

import SwiftUI
import CoreData

final class CoreDataManager: DataManaging{
    private let container = NSPersistentContainer(name: "Library")
    private var context: NSManagedObjectContext { container.viewContext }
    
    init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data failed to create container: \(error.localizedDescription)")
            }
        }
    }
    
    // 1. Získání dat pro View seznamu
    func fetchBooks() -> [Book]{
        let request = NSFetchRequest<BookEntity>(entityName: "BookEntity")
        
        do {
            let entities = try context.fetch(request)
            
            return entities.map{ entity in
                return Book(
                    id: entity.id ?? UUID(),
                    title: entity.title ?? "No title",
                    genre: Genre(rawValue: entity.genre ?? "") ?? .textbook ,
                    author: entity.author ?? "No author",
                    
                    //Loan
                    // Získání konkrétního loanu přes relaci v Core Data
                    loan: entity.loan.map { loanEntity in
                        Loan(
                            borrowerName: loanEntity.borrowerName ?? "",
                            borrowed: loanEntity.borrowed ?? Date(),
                            borrowedUntil: loanEntity.borrowedUntil ?? Date()
                        )
                    }
                )
            }
        } catch {
            print("CoreDataManager fetchBooks error: \(error.localizedDescription)")
            return []
        }

    }
        
        // 2. Uložení nové výpůjčky (z modálního okna Add Loan)
    func addLoan(to book: Book, readerName: String, dueDate: Date){
        
        //SELECT * FROM BookEntity WHERE id = 'hodnota'
        let request = NSFetchRequest<BookEntity>(entityName: "BookEntity")
            // OPRAVA 1: Kniha má parametr 'book', ne 'item'
            request.predicate = NSPredicate(format: "id == %@", book.id as CVarArg)
            // Omezíme výsledek na 1, jelikož hledáme konkrétní ID
            request.fetchLimit = 1
        
        do {
                let results = try context.fetch(request)
                if let bookEntity = results.first {
                    let newLoanEntity = LoanEntity(context: context)
                    newLoanEntity.borrowerName = readerName
                    newLoanEntity.borrowed = Date() // Aktuální datum výpůjčky
                    newLoanEntity.borrowedUntil = dueDate
                    // OPRAVA 4: Propojení relace (Zápůjčka je přiřazena ke knize)
                    bookEntity.loan = newLoanEntity
                    
                    // OPRAVA 5: Skutečné uložení do databáze
                    if context.hasChanges {
                        try context.save()
                    }
                }
            } catch {
                print("CoreDataManager addLoan error: \(error.localizedDescription)")
            }
    }
        
    // 3. Vrácení detailu knihy
    func returnBook(_ book: Book) -> Book {
        let request = NSFetchRequest<BookEntity>(entityName: "BookEntity")
        request.predicate = NSPredicate(format: "id == %@", book.id as CVarArg)
        request.fetchLimit = 1
        
        do {
            let results = try context.fetch(request)
            
            if let entity = results.first {
                return Book(
                    id: entity.id ?? book.id,
                    title: entity.title ?? book.title,
                    genre: Genre(rawValue: entity.genre ?? "") ?? book.genre,
                    author: entity.author ?? book.author,
                    
                    // Načtení zápůjčky, pokud existuje
                    loan: entity.loan.map { loanEntity in
                        Loan(
                            borrowerName: loanEntity.borrowerName ?? "",
                            borrowed: loanEntity.borrowed ?? Date(),
                            borrowedUntil: loanEntity.borrowedUntil ?? Date()
                        )
                    }
                )
            }
        } catch {
            print("CoreDataManager returnBook error: \(error.localizedDescription)")
        }
        
        // Fallback: Pokud se načtení z DB nepovede, vrátí se původní kniha
        return book
    }
}


// MARK: Private methods
private extension CoreDataManager {

    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Cannot save MOC: \(error.localizedDescription)")
            }
        }
    }
}
