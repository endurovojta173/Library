//
//  ListView.swift
//  Library
//
//  Created by endurovojta173 on 25.05.2026.
//

import SwiftUI

struct ListView: View{
    @State private var viewModel: ListViewModel
    @State private var isAddLoanPresented: Bool = false
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View{
        NavigationStack{
            VStack{
                List(viewModel.state.books) { book in
                    HStack{
                        //Leva cast informace o knize
                        VStack(alignment: .leading) {
                            Text(book.genre.rawValue)
                                .font(.subheadline)
                            Text(book.title)
                                .font(.headline)
                            Text(book.author)
                                .font(.default)
                        }
                        //Odtlaci doprava
                        Spacer()
                        //Prava cast informace o knize
                        VStack(alignment: .trailing){
                            if((book.loan?.borrowerName) != nil){
                                Text("Borrowed")
                                    .font(.headline)
                                    .foregroundStyle(.red)
                                let days: Int = viewModel.remainingTime(book: book)
                                if days > -1 {
                                    Text(String(days) + " d")
                                        .font(.headline)
                                }
                                else{
                                    Text(String(days) + " d")
                                        .font(.headline)
                                        .foregroundStyle(.red)
                                }
                            }
                            else{
                                Text("Free")
                                    .font(.headline)
                                    .foregroundStyle(.green)
                                Text("- d")
                            }
                            //Odkaz na danou knihu
                            NavigationLink {
                                DetailView(viewModel: DetailViewModel(book: book))
                            } label: {
                                Text("")
                            }

                        }
                    }
                }
                .onAppear {
                    viewModel.fetchBooks()
                }
            }
            // Title navigace
            .navigationTitle("Library")
            // Button pro zapnuti modalniho okna pro pridani lokace
            .toolbar {
                Button {
                    isAddLoanPresented = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                }
            }
            // Bile pozadi navbaru
            .toolbarBackground(.white, for: .navigationBar)
            
        }
        .sheet(isPresented: $isAddLoanPresented){
            showAddLoan()
        }
    }
    
    //Modalni okno loan
    private func showAddLoan() -> some View {
        NavigationStack {
            AddLoanView(viewModel: viewModel)
                .navigationTitle("Add Loan")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Close") {
                            isAddLoanPresented = false
                        }
                    }
                }
        }
        .presentationDetents([.large])
        .presentationBackground(Color(.systemBackground))
    }
}
