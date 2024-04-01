//
//  FriendsService.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 30/03/2024.
//

import Foundation

/// An actor responsible for managing and providing data related to friends within the application.
///
/// This actor utilizes `UnsplashService` to simulate fetching friend information and their associated galleries from a network service. Each friend is assigned a default avatar from a preset URL, and their galleries are populated with images fetched from Unsplash.
actor FriendsService {
    /// The service used to fetch featured photos from Unsplash.
    private let imageService = UnsplashService()
    
    /// A default avatar URL used as a placeholder for all friends.
    ///
    /// In cases where specific avatars for friends are not available or not fetched, this default avatar is used.
    private let defaultAvatar = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLurZoNcUv3FZ26c3I_VoEeI45erY_RHiSjH-dUJH1mA&s"

    /// Fetches a list of friends with their avatars and galleries.
    ///
    /// This method simulates fetching a list of friends. Each friend is assigned a default avatar or an avatar from a list of URLs fetched via `UnsplashService`.
    ///
    /// - Returns: An array of `FriendModel` instances representing the friends list. Each friend has an avatar and a potentially empty gallery.
    func getFriendsList() async -> [FriendModel] {
        let friends = [
            FriendModel(name: "Mike", avatar: defaultAvatar, pictooChats: []),
            FriendModel(name: "Kate", avatar: defaultAvatar, pictooChats: []),
            FriendModel(name: "James", avatar: defaultAvatar, pictooChats: []),
            FriendModel(name: "Olivia", avatar: defaultAvatar, pictooChats: [])
        ]
        
        let urls = await imageService.getFeaturedPhotos()
        
        for i in 0..<friends.count {
            friends[i].avatar = urls.isEmpty ? defaultAvatar : urls[i % urls.count]
            friends[i].pictooChats = await getFriendGallery(for: friends[i].id)?.shuffled() ?? []
        }
        
        return friends
    }
    
    /// Fetches a gallery for a specific friend identified by their `ID`.
    ///
    /// This method simulates fetching a gallery (pictooChats) for a friend by utilizing `UnsplashService` to fetch photo URLs.
    ///
    /// - Parameter ID: The unique identifier of the friend whose gallery is being fetched.
    /// - Returns: An optional array of `PictooChatModel` instances representing the friend's gallery. Returns `nil` if no images could be fetched or the URLs are invalid.
    func getFriendGallery(for ID: UUID) async -> [PictooChatModel]? {
        let stringURLs = await imageService.getFeaturedPhotos()
        guard !stringURLs.isEmpty else {
            return nil
        }

        let pictooChats = stringURLs.compactMap { stringURL -> PictooChatModel? in
            guard let url = URL(string: stringURL) else { return nil }
            return PictooChatModel(imageURL: url, messages: [], chatCircle: [])
        }
        
        return pictooChats.isEmpty ? nil : pictooChats
    }
}
