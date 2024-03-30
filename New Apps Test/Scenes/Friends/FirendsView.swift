//
//  FirendsView.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 29/03/2024.
//

import SwiftUI

struct FirendsView: View {
    @State var friends: [FriendModel] = []
    
    var body: some View {
        NavigationStack {
            ScrollView() {
                VStack(alignment: .leading, spacing: 24) {
                    ForEach(friends) { friend in
                        NavigationLink {
                            GalleryView()
                        } label: {
                            FriendRow(friend: friend)
                        }
                    }
                }
            }
            .frame(maxWidth:.infinity)
            .navigationTitle("Friends")
            .padding(.top, 24)
        }
        .task {
            friends = [FriendModel.mike, FriendModel.kate]
        }
    }
}

#Preview {
    FirendsView()
}
