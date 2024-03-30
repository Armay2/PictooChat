//
//  FirendsView.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 29/03/2024.
//

import SwiftUI

actor FriendsService {
    var imageService = UnsplashService()

    func getFriendsList() async -> [FriendModel] {
        let urls = await imageService.getFeaturedPhotos()
        
        let friends = [
            FriendModel(name: "Mike", avatar: urls.shuffled().first!, imagesThumnail: urls.map { URL(string: $0)! }.shuffled()),
            FriendModel(name: "Kate", avatar: urls.shuffled().first!, imagesThumnail: urls.map { URL(string: $0)! }.shuffled()),
            FriendModel(name: "James", avatar: urls.shuffled().first!, imagesThumnail: urls.map { URL(string: $0)! }.shuffled()),
            FriendModel(name: "Olivia", avatar: urls.shuffled().first!, imagesThumnail: urls.map { URL(string: $0)! }.shuffled()),
        ]
        return friends
    }
    
    func getFriendGallery() async -> [PictooChat] {
        let stringURLs = await imageService.getFeaturedPhotos()
        let pictooChats = stringURLs.map { stringURL in
            PictooChat(imageURL: URL(string: stringURL)!, messages: [])
        }
        
        return pictooChats
    }
}

struct FirendsView: View {
    let friendsService = FriendsService()
    @State var friends: [FriendModel] = []
    
    var body: some View {
        NavigationStack {
            ScrollView() {
                VStack(alignment: .leading, spacing: 24) {
                    ForEach(friends) { friend in
                        NavigationLink {
                            FriendGalleryView()
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

#Preview {
    FirendsView()
}
