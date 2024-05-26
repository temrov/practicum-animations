//
//  SwiftUIView.swift
//  FavoriteImages
//
//  Created by Vadim Temnogrudov on 25.05.2024.
//

import SwiftUI

struct LikeView: View {
    let liked: Bool
    var body: some View {
        Image(systemName: liked ? "heart.fill" : "heart")
            .renderingMode(.template)
            .foregroundStyle(liked ? .red : .primary)
    }
}

#Preview {
    VStack {
        LikeView(liked: true)
        LikeView(liked: false)
    }
}
