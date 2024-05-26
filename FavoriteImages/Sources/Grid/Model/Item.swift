/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct Item: Identifiable, Equatable {

    let id = UUID()
    let url: URL
    let likesCount: Int = .random(in: 30 ... 2000)
}
