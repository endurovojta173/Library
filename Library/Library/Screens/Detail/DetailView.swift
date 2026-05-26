//
//  DetailView.swift
//  Library
//
//  Created by endurovojta173 on 25.05.2026.
//

import SwiftUI

struct DetailView: View{
    @State private var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View{
        NavigationStack{
            VStack{
                Section(header: Text("Book")) {
                    Text(viewModel.state.book.title)
                }
                Section(header: Text("Author")) {
                    Text(viewModel.state.book.author)
                }
                Section(header: Text("Reader")) {
                    Text(viewModel.state.book.loan?.borrowerName ?? "Not borrowed")
                }
                HStack{
                    Section(header: Text("Borrowed")) {
                        Text(viewModel.state.book.loan?.borrowed.formatted(date: .numeric, time: .omitted) ?? "Not borrowed")
                    }
                    Section(header: Text("Until")) {
                        Text(viewModel.state.book.loan?.borrowedUntil.formatted(date: .numeric, time: .omitted) ?? "Not borrowed")
                    }
                    
                }
                

            }
            // Title navigace
            .navigationTitle("Loan")
            // Button pro zapnuti modalniho okna pro pridani lokace
            .toolbar {
                if((viewModel.state.book.loan) == nil){
                        Text("Returned")
                }else{
                    Button {
                        viewModel.freeBook()
                    } label: {
                        Text("Taken")
                    }
                }
                
            }
            // Bile pozadi navbaru
            .toolbarBackground(.white, for: .navigationBar)
        }
    }
}
