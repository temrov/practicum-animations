/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct GridView: View {
    @StateObject private var dataModel: DataModel = DataModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .center, spacing: 16, content: {
                    ForEach(dataModel.items) { item in
                        GridItemView(
                            item: item,
                            isLiked: isLikedBinding(itemId: item.id),
                            doubleTapTrigger: .constant(0) // reserved for future handling
                        )
                    }
                })
                .padding()
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
 
