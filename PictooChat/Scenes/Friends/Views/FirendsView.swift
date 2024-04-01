//
//  FirendsView.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 29/03/2024.
//

import SwiftUI



struct FirendsView: View {
    let friendsService = FriendsService()
    @State var friends: [FriendModel] = []
    
    var body: some View {
        NavigationStack {
            ScrollView() {
                VStack(alignment: .leading, spacing: 24) {
                    ForEach(friends) { friend in
                        NavigationLink {
                            FriendGalleryView(friend: friend)
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
             friends = await friendsService.getFriendsList()
        }
    }
}

#if DEBUG
#Preview {
    FirendsView()
}
#endif
