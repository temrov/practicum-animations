/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

enum InlineLikeViewPhase: CaseIterable {
    case start, end
    var scale: CGFloat {
        switch self {
        case .start: 1
        case .end: 1.2
        }
    }
}

struct GridItemView: View {
    let item: Item
    @Binding var isLiked: Bool
    @Binding var doubleTapTrigger: Int
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            AsyncImage(
                url: item.url
            ) { phase in
                switch phase {
                case .success(let image):
                    image.framedAspectRatio(1, contentMode: .fill)
                default:
                    ProgressView()
                }
            }
            .fixedAspectRatio(1, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .contentShape(Rectangle())
            .onTapGesture(count: 2) {
                isLiked = true
                doubleTapTrigger += 1
            }

            HStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                LikeView(liked: isLiked)
                    .onTapGesture {
                        isLiked.toggle()
                    }
                Text(likeText)
                    .animation(nil, value: isLiked)
            })
            .frame(height: 32)
        }
    }

    private var likeText: String {
        let othersLiked = "\(item.likesCount) others liked"
        return isLiked ? "You and \(othersLiked)" : othersLiked
    }
}

extension View {
    public func framedAspectRatio(_ aspect: CGFloat? = nil, contentMode: ContentMode) -> some View where Self == Image {
        self.resizable()
            .fixedAspectRatio(contentMode: contentMode)
            .allowsHitTesting(false)
    }

    public func fixedAspectRatio(_ aspect: CGFloat? = nil, contentMode: ContentMode) -> some View {
        self.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .aspectRatio(aspect, contentMode: contentMode)
            .clipped()
    }
}

#Preview {
    GridItemView(
        item: Item(
            url: Bundle.main.url(
                forResource: "bobcat",
                withExtension: "jpg"
            )!
        ),
        isLiked: .constant(false), 
        doubleTapTrigger: .constant(0)
    )
}
