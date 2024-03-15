//
//  ContentView.swift
//  Magic Browser
//
//  Created by Marcus Isaksson on 2024-03-11.
//

import SwiftUI
import Combinefall

struct ContentView: View {
    @State var search: String = ""
    @State var result: [String] = []
    
    let autocompleteHandler = AutocompleteHandler()
    
    var body: some View {
        NavigationStack {
            TextField("Search", text: $search)
            List(result, id: \.self) {
                NavigationLink($0, value: $0)
            }
            .navigationDestination(for: String.self) { Card(cardName: $0) }
        }
        .onChange(of: search, initial: false) {
            guard !search.isEmpty, search != "" else {
                result = []
                return
            }
            Task {
                guard let newResult = try? await autocompleteHandler.autocomplete(query: search) else { return }
                result = newResult
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
