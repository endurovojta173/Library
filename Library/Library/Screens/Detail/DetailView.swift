import SwiftUI

struct DetailView: View {
    @State private var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        // ODEBRÁNO: NavigationStack (DetailView už v jednom stacku je z ListView, jinak by se vám zdvojil navbar)
        List {
            Section(header: Text("Book")) {
                Text(viewModel.state.book.title)
                    .font(.headline)
                    .fontWeight(.bold)
            }
            
            Section(header: Text("Author")) {
                Text(viewModel.state.book.author)
                    .font(.headline)
                    .fontWeight(.bold)
            }
            
            Section(header: Text("Reader")) {
                Text(viewModel.state.book.loan?.borrowerName ?? "Not borrowed")
                    .font(.headline)
                    .fontWeight(.bold)
            }
            
            // Spodní data vedle sebe vyřešíme pomocí HStacku s dvěma sloupci uvnitř jedné sekce
            Section {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Borrowed")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .textCase(.uppercase)
                        Text(viewModel.state.book.loan?.borrowed.formatted(date: .numeric, time: .omitted) ?? "—")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    
                    Spacer() // Vytlačí druhou informaci doprava
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Until")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .textCase(.uppercase)
                        Text(viewModel.state.book.loan?.borrowedUntil.formatted(date: .numeric, time: .omitted) ?? "—")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    
                    Spacer() // Zarovná design, aby neodskakoval k úplnému okraji
                }
                .padding(.vertical, 4)
            }
            // Sekce pro obal knihy
            Section {
                HStack {
                    Spacer()
                    if let imageName = viewModel.state.book.coverImageName, !imageName.isEmpty {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200) // Nastavte výšku podle potřeby
                            .cornerRadius(8)
                            .shadow(radius: 4)
                    } else {
                        // Fallback, pokud obal chybí
                        Image(systemName: "book.closed")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 120)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .listRowBackground(Color.clear)
            }
            
        }
        .listStyle(.insetGrouped) // Zajistí moderní zaoblené bloky na šedém pozadí
        .navigationTitle("Loan")
        .navigationBarTitleDisplayMode(.inline) // Zmenší nadpis "Loan" doprostřed lišty jako na screenu
        .toolbar {
            if viewModel.state.book.loan == nil {
                Text("Returned")
                    .foregroundColor(.gray)
            } else {
                Button {
                    viewModel.freeBook()
                } label: {
                    Text("Returned") // Na screenshotu máte tlačítko "Returned", v kódu bylo "Taken"
                }
            }
        }
        .toolbarBackground(.white, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}
