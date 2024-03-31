//
//  FriendRow.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 29/03/2024.
//

import SwiftUI

struct FriendRow: View {
    let friend: FriendModel
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                AsyncImage(url: URL(string: friend.avatar)) { image in
                    image
                        .resizable()
                        .clipShape(Capsule())
                        .frame(width: 40, height: 40)
                } placeholder: {
                    LoadingImageView()
                        .clipShape(Circle())
                        .frame(width: 40, height: 40)
                }
                Text(friend.name)
                    .font(.headline)
                Spacer()
            }
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(friend.pictooChats) { pictooChat in
                        AsyncImage(url: pictooChat.imageURL) { image in
                            image
                                .resizable()
                                .cornerRadius(8)
                                .frame(width: 100, height: 100)
                        } placeholder: {
                            LoadingImageView()
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
    FriendRow(friend: FriendModel.mike)
}
#endif
