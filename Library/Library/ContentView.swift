//
//  ContentView.swift
//  Library
//
//  Created by endurovojta173 on 25.05.2026.
//

import SwiftUI

struct ContentView: View {
    var viewModel = ListViewModel()
    var body: some View {
        ListView(viewModel: viewModel)
    }
}
/*
#Preview {
    ContentView()
}
*/
