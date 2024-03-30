//
//  FriendRow.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 29/03/2024.
//

import SwiftUI

struct Friend: Identifiable {
    let id = UUID()
    let name: String
    let avatar: String
    let PictooChats: [PictooChat]
    
#if DEBUG
    static let mike = Friend(name: "Mike",
                             avatar: "https://images.unsplash.com/photo-1707343846292-56e4c6abf291?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NzU3Mjd8MXwxfGFsbHw2fHx8fHx8Mnx8MTcxMTczODE2OHw&ixlib=rb-4.0.3&q=80&w=1080",
                             PictooChats: [PictooChat.chat1,
                                           PictooChat.chat2,
                                           PictooChat.chat3,
                                           PictooChat.chat4])
    static let kate = Friend(name: "Kate",
                             avatar: "https://images.unsplash.com/photo-1711539924834-06816347ff2a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NzU3Mjd8MHwxfGFsbHw4fHx8fHx8Mnx8MTcxMTczODE2OHw&ixlib=rb-4.0.3&q=80&w=1080",
                             PictooChats: [PictooChat.chat2,
                                           PictooChat.chat4,
                                           PictooChat.chat3,
                                           PictooChat.chat1])
#endif
}

struct FriendRow: View {
    let friend: Friend
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                AsyncImage(url: URL(string: friend.avatar)) { image in
                    image
                        .resizable()
                        .clipShape(Capsule())
                        .frame(width: 40, height: 40)
                } placeholder: {
                    Circle()
                        .frame(width: 40, height: 40)
                }
                Text(friend.name)
                    .font(.headline)
                Spacer()
            }
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(friend.PictooChats) { pictooChat in
                        AsyncImage(url: pictooChat.imageURL) { image in
                            image
                                .resizable()
                                .cornerRadius(8)
                                .frame(width: 100, height: 100)
                        } placeholder: {
                            Rectangle()
                                .frame(width: 100, height: 100)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .frame(height: 100)
        }
        .padding(.leading)
    }
}

#if DEBUG
#Preview {
    FriendRow(friend: Friend.mike)
}
#endif
