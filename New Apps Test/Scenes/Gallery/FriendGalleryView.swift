//
//  FriendGalleryView.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 30/03/2024.
//

import SwiftUI

struct FriendGalleryView: View {
    
    @State var pictooChats: [PictooChat] = []
    
    let friendsService = FriendsService()
    let gridLayout = [
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 40))
    ]
    
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
        .navigationTitle("Mike")
        .task {
            pictooChats = await friendsService.getFriendGallery()
        }
    }
    
}

#Preview {
    FriendGalleryView()
}
