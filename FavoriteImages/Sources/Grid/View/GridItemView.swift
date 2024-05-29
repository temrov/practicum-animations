/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct GridItemView: View {
    let item: Item
    @Binding var isLiked: Bool
    @Binding var doubleTapTrigger: CGPoint
    @State private var alreadyLikedInlineLikeTrigger = 0
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
            .onTapGesture(count: 2, coordinateSpace: .global, perform: { point in
                if isLiked {
                    alreadyLikedInlineLikeTrigger += 1
                } else {
                    isLiked = true
                }
                doubleTapTrigger = point
                print("Double tap \(point)")
            })

            HStack {
                LikeView(liked: isLiked)
                    .onTapGesture {
                        isLiked.toggle()
                    }
                    .phaseAnimator(
                        [0, 1],
                        trigger: alreadyLikedInlineLikeTrigger
                    ) { content, phase in
                        content.scaleEffect(phase == 0 ? 1 : 1.5)
                    }
                Text(likeText)
            }
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
        doubleTapTrigger: .constant(.zero)
    )
}
