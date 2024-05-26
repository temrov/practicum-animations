//
//  FlyingLikeView.swift
//  FavoriteImages
//
//  Created by Vadim Temnogrudov on 26.05.2024.
//

import SwiftUI

struct FlyingLikeView: View {
    let trigger: Int
    var body: some View {
        Image(systemName: "heart.fill")
            .foregroundStyle(.red)
            .font(.system(size: 72))
            .phaseAnimator(
                LikeAnimationPhase.allCases,
                trigger: trigger,
                content: { content, phase in
                    content
                        .scaleEffect(phase.scale)
                        .opacity(phase.opacity)
                        .rotationEffect(phase.rotation)
                }
            ) { phase in
                switch phase {
                case .rotatesLeft, .rotatesRight:
                    .spring()
                default:
                    .easeInOut
                }
            }

    }
}

enum LikeAnimationPhase: Int, CaseIterable {
    case start
    case appeared
    case rotatesLeft
    case rotatesRight
    case end

    var opacity: CGFloat {
        switch self {
        case .start:
            0
        default:
            1
        }
    }
    var scale: CGFloat {
        switch self {
        case .start:
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

}
