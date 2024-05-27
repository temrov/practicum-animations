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
        if liked {
            likedImage
        } else {
            notLikedImage
        }
    }

    private var likedImage: some View {
        Image(systemName: "heart.fill")
            .foregroundStyle(.red)
            .transition(.scale(scale: 0).combined(with: .opacity).animation(.spring(
                dampingFraction: 0.5,
                blendDuration: 0.4
            )))
    }

    private var notLikedImage: some View {
        Image(systemName: "heart")
            .foregroundStyle(.primary)
            .transition(.scale(scale: 0).combined(with: .opacity).animation(.default))

    }
}

#Preview {
    VStack {
        LikeView(liked: true)
        LikeView(liked: false)
    }
}
