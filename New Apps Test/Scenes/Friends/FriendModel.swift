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
    let PictooChats: [PictooChat]
    
#if DEBUG
    static let mike = FriendModel(name: "Mike",
                             avatar: "https://images.unsplash.com/photo-1707343846292-56e4c6abf291?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NzU3Mjd8MXwxfGFsbHw2fHx8fHx8Mnx8MTcxMTczODE2OHw&ixlib=rb-4.0.3&q=80&w=1080",
                             PictooChats: [PictooChat.chat1,
                                           PictooChat.chat2,
                                           PictooChat.chat3,
                                           PictooChat.chat4])
    static let kate = FriendModel(name: "Kate",
                             avatar: "https://images.unsplash.com/photo-1711539924834-06816347ff2a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NzU3Mjd8MHwxfGFsbHw4fHx8fHx8Mnx8MTcxMTczODE2OHw&ixlib=rb-4.0.3&q=80&w=1080",
                             PictooChats: [PictooChat.chat2,
                                           PictooChat.chat4,
                                           PictooChat.chat3,
                                           PictooChat.chat1])
#endif
}