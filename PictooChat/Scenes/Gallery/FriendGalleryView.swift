//
//  FriendGalleryView.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 30/03/2024.
//

import SwiftUI

struct FriendGalleryView: View {
    let friend: FriendModel
    let friendsService = FriendsService()
    
    let gridLayout = [
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 40))
    ]
    @State var pictooChats: [PictooChatModel] = []

    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                ForEach(pictooChats) { pictooChat in
                    NavigationLink {
                        PictooChatView(pictooChat: pictooChat)
                    } label: {
                        AsyncImage(url: pictooChat.imageURL) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .cornerRadius(10)
                        } placeholder: {
                            LoadingImageView()
                            .frame(width: 100, height: 100)
                        }
                    }
                }
            }
            .padding(10)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(friend.name.capitalized)
        .task {
            pictooChats = await friendsService.getFriendGallery(for: friend.id) ?? []
        }
    }
    
}

#if DEBUG
#Preview {
    FriendGalleryView(friend: FriendModel.kate)
}
#endif
