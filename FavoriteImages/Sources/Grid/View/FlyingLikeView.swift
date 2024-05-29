//
//  FlyingLikeView.swift
//  FavoriteImages
//
//  Created by Vadim Temnogrudov on 26.05.2024.
//

import SwiftUI

struct FlyingLikeView: View {
    var body: some View {
        Image(systemName: "heart.fill")
            .foregroundStyle(.red)
            .font(.system(size: 72))


    }
}

enum LikeAnimationPhase: Int, CaseIterable {
    case prestart
    case start
    case appeared
    case rotatesLeft
    case rotatesRight
    case end
    case postEnd

    var opacity: CGFloat {
        switch self {
        case .start, .prestart, .postEnd:
            0
        default:
            1
        }
    }
    var scale: CGFloat {
        switch self {
        case .start, .prestart:
            0.5
        default:
            1
        }
    }
    var rotation: Angle {
        switch self {
        case .rotatesLeft:
            .degrees(-20)
        case .rotatesRight:
            .degrees(20)
        default:
            .zero
        }
    }

    func offset(startOffset: CGPoint) ->(x: CGFloat, y: CGFloat) {
        switch self {
        case .end, .postEnd:
            (UIScreen.main.bounds.width / 2, -.flyingHeartHeight)
        default:
            (startOffset.x, startOffset.y)
        }
    }

}
