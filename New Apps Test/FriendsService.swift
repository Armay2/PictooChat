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
        let defaultAvatar = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLurZoNcUv3FZ26c3I_VoEeI45erY_RHiSjH-dUJH1mA&s")! // Placeholder for a default avatar.
        
        let friends = [
            FriendModel(name: "Mike", avatar: urls.shuffled().first ?? defaultAvatar.absoluteString, pictooChats: await getFriendGallery()),
            FriendModel(name: "Kate", avatar: urls.shuffled().first ?? defaultAvatar.absoluteString, pictooChats: await getFriendGallery()),
            FriendModel(name: "James", avatar: urls.shuffled().first ?? defaultAvatar.absoluteString, pictooChats: await getFriendGallery()),
            FriendModel(name: "Olivia", avatar: urls.shuffled().first ?? defaultAvatar.absoluteString, pictooChats: await getFriendGallery()),
        ]
        return friends
    }
    
    func getFriendGallery() async -> [PictooChat] {
        let stringURLs = await imageService.getFeaturedPhotos()
        let pictooChats = stringURLs.compactMap { stringURL -> PictooChat? in
            guard let url = URL(string: stringURL) else { return nil }
            return PictooChat(imageURL: url, messages: [])
        }
        
        return pictooChats
    }
}
