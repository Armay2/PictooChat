//
//  FriendsService.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 30/03/2024.
//

import Foundation

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
