/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct GridView: View {
    @StateObject private var dataModel: DataModel = DataModel()

    @State private var doubleTapTrigger: CGPoint = .zero
    var body: some View {
        ZStack(alignment: .topLeading, content: {
            NavigationStack {
                ScrollView {
                    LazyVStack(alignment: .center, spacing: 16) {
                        ForEach(dataModel.items) { item in
                            GridItemView(
                                item: item,
                                isLiked: isLikedBinding(itemId: item.id),
                                doubleTapTrigger: $doubleTapTrigger
                            )
                        }
                    }
                    .padding()
                }
                .navigationBarTitle("Image Gallery")
            }
            FlyingLikeView()
                .frame(width: .flyingHeartSize, height: .flyingHeartSize)
                .ignoresSafeArea()
                .phaseAnimator(
                    LikeAnimationPhase.allCases,
                    trigger: doubleTapTrigger,
                    content: { content, phase in
                        let offset = phase.offset(startOffset: doubleTapTrigger)
                        content
                            .scaleEffect(phase.scale)
                            .opacity(phase.opacity)
                            .rotationEffect(phase.rotation)
                            .offset(x: offset.x - .flyingHeartSize / 2, y: offset.y - .flyingHeartSize)
                    }
                ) { phase in
                    switch phase {
                    case .rotatesLeft, .rotatesRight:
                        .spring()
                    case .postEnd, .start:
                            .linear(duration: 0.01)
                    default:
                        .easeInOut
                    }
                }
        })

    }

    private func isLikedBinding(itemId: UUID) -> Binding<Bool> {
        Binding {
            dataModel.liked.contains(itemId)
        } set: { newValue in
            if newValue {
                dataModel.liked.insert(itemId)
            } else {
                dataModel.liked.remove(itemId)
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
            .previewDevice("iPad (8th generation)")
    }
}
 
private extension CGFloat {

    static let flyingHeartSize: CGFloat = 100
}
