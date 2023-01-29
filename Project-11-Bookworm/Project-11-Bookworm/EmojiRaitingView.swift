//
//  EmojiRaitingView.swift
//  Project-11-Bookworm
//
//  Created by Pawel Baranski on 23/01/2023.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating: Int16

    var body: some View {
        switch rating {
        case 1:
            Text("😔")
        case 2:
            Text("😕")
        case 3:
            Text("🙂")
        case 4:
            Text("😎")
        default:
            Text("🤩")
        }
    }
}

struct EmojiRaitingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: 3)
    }
}
