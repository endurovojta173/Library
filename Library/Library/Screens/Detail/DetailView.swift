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
               Text("Book")
                Text(viewModel.state.book.title)
            }
            // Title navigace
            .navigationTitle("Library")
            // Button pro zapnuti modalniho okna pro pridani lokace
            .toolbar {
                Button {
                    //isNewMapItemViewPresented = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                }
            }
            // Bile pozadi navbaru
            .toolbarBackground(.white, for: .navigationBar)
        }
    }
}
