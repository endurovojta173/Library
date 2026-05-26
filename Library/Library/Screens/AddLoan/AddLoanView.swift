import SwiftUI

struct AddLoanView: View {
    @Environment(\.dismiss) private var dismiss
    
    // Odkaz na existující ListViewModel, který už máš
    private var viewModel: ListViewModel
    
    @State private var selectedBook: Book
    @State private var readerName: String = ""
    @State private var dueDate: Date = Date()
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        // Jako výchozí knihu v pickeru nastavíme první knihu ze state ListViewModelu
        self._selectedBook = State(initialValue: viewModel.state.books.first ?? Book.getSampleWithoutLoan())
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Book")) {
                    Picker("Kniha", selection: $selectedBook) {
                        // Taháme knihy přímo z ListViewModelu
                        ForEach(viewModel.state.books) { book in
                            Text(book.title).tag(book)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section(header: Text("Borrower")) {
                    TextField("Name", text: $readerName)
                    DatePicker("Until", selection: $dueDate, displayedComponents: .date)
                }
            }
            .navigationTitle("Add Loan")
            .toolbar {
                Button {
                    // Zavoláme uložení přímo na hlavním ViewModelu
                    viewModel.addLoan(to: selectedBook, readerName: readerName, dueDate: dueDate)
                    dismiss()
                } label: {
                    Text("Save")
                }
                .disabled(readerName.isEmpty)
            }
        }
    }
}
