//
//  Card.swift
//  Magic Browser
//
//  Created by Marcus Isaksson on 2024-03-11.
//

import SwiftUI
import Combinefall

struct Card: View {
    let cardName: String
    
    @State private var card: Combinefall.Card?
    
    var body: some View {
        if let card {
            AsyncImage(url: card.imageUrls?.normal) {
                $0.image?
                    .resizable()
                    .scaledToFit()
            }
            Text(card.name)
        } else {
           ProgressView()
                .task { card = try? await Combinefall.card(using: .exact(cardName)) }
        }
    }
}

#Preview {
    Card(cardName: "Grizzly Bears")
}
