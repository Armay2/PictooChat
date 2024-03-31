//
//  FriendGalleryView.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 30/03/2024.
//

import SwiftUI
@Observable
class PictooChat: Identifiable {
    let id = UUID()
    let imageURL: URL
    var messages: [Message]
    var chatCircle: [ChatCircle]

    internal init(imageURL: URL, messages: [Message], chatCircle: [ChatCircle]) {
        self.imageURL = imageURL
        self.messages = messages
        self.chatCircle = chatCircle
    }
    
#if DEBUG
    static let chat1 = PictooChat(imageURL: URL(string: "https://images.unsplash.com/photo-1683009427042-e094996f9780?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NzU3Mjd8MXwxfGFsbHwxfHx8fHx8Mnx8MTcxMTczODE2OHw&ixlib=rb-4.0.3&q=80&w=1080")!,
                                  messages: [],
                                  chatCircle: [])
    static let chat2 = PictooChat(imageURL: URL(string: "https://images.unsplash.com/photo-1711539924834-06816347ff2a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NzU3Mjd8MHwxfGFsbHw4fHx8fHx8Mnx8MTcxMTczODE2OHw&ixlib=rb-4.0.3&q=80&w=1080")!,
                                  messages: [],
                                  chatCircle: [])
    static let chat3 = PictooChat(imageURL: URL(string: "https://images.unsplash.com/photo-1711627295683-d73c279604f7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NzU3Mjd8MHwxfGFsbHwxMHx8fHx8fDJ8fDE3MTE3MzgxNjh8&ixlib=rb-4.0.3&q=80&w=1080")!,
                                  messages: [],
                                  chatCircle: [])
    static let chat4 = PictooChat(imageURL: URL(string: "https://images.unsplash.com/photo-1711654106922-f44ee5df26ba?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NzU3Mjd8MHwxfGFsbHw0fHx8fHx8Mnx8MTcxMTczODE2OHw&ixlib=rb-4.0.3&q=80&w=1080")!,
                                  messages: [],
                                  chatCircle: [])
#endif
}


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
