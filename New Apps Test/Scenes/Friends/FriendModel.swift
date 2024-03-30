//
//  FriendModel.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 30/03/2024.
//

import Foundation

struct FriendModel: Identifiable {
    let id = UUID()
    let name: String
    let avatar: String
    let imagesThumnail: [URL]
    
#if DEBUG
    static let mike = FriendModel(name: "Mike",
                             avatar: "https://images.unsplash.com/photo-1707343846292-56e4c6abf291?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NzU3Mjd8MXwxfGFsbHw2fHx8fHx8Mnx8MTcxMTczODE2OHw&ixlib=rb-4.0.3&q=80&w=1080",
                                  imagesThumnail: [PictooChat.chat1.imageURL,
                                                   PictooChat.chat2.imageURL,
                                           PictooChat.chat3.imageURL,
                                           PictooChat.chat4.imageURL])
    static let kate = FriendModel(name: "Kate",
                             avatar: "https://images.unsplash.com/photo-1711539924834-06816347ff2a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NzU3Mjd8MHwxfGFsbHw4fHx8fHx8Mnx8MTcxMTczODE2OHw&ixlib=rb-4.0.3&q=80&w=1080",
                                  imagesThumnail: [PictooChat.chat2.imageURL,
                                           PictooChat.chat4.imageURL,
                                           PictooChat.chat3.imageURL,
                                           PictooChat.chat1.imageURL])
#endif
}
