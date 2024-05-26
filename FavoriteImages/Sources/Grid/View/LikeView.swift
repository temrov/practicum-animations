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
        ZStack {
            likedImage
            notLikedImage
        }
    }

    private var likedImage: some View {
        Image(systemName: "heart.fill")
            .foregroundStyle(.red)
            .scaleEffect(liked ? 1 : 0)
            .opacity(liked ? 1 : 0)
            .animation(
                .spring(
                    dampingFraction: 0.5,
                    blendDuration: 0.4
                ),
                value: liked
            )
    }

    private var notLikedImage: some View {
        Image(systemName: "heart")
            .foregroundStyle(.primary)
            .scaleEffect(liked ? 0 : 1)
            .opacity(liked ? 0 : 1)
            .animation(.default, value: liked)
    }
}

#Preview {
    VStack {
        LikeView(liked: true)
        LikeView(liked: false)
    }
}
