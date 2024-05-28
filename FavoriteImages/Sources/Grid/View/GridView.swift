/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct GridView: View {
    @StateObject private var dataModel: DataModel = DataModel()

    @State private var doubleTapTrigger = 0
    var body: some View {
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
            .overlay {
                FlyingLikeView(trigger: doubleTapTrigger)
            }
            .navigationBarTitle("Image Gallery")
        }
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
 
