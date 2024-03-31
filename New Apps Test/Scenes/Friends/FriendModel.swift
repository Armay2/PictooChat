//
//  FriendModel.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 30/03/2024.
//

import Foundation

@Observable
class FriendModel: Identifiable {
    let id = UUID()
    let name: String
    var avatar: String
    var pictooChats: [PictooChatModel] // Assuming PictooChat is a defined structure elsewhere in your project.
    
    internal init(name: String, avatar: String, pictooChats: [PictooChatModel]) {
        self.name = name
        self.avatar = avatar
        self.pictooChats = pictooChats
    }
    
#if DEBUG
    static let mike = FriendModel(name: "Mike",
                                  avatar: "https://images.unsplash.com/photo-1707343846292-56e4c6abf291?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NzU3Mjd8MXwxfGFsbHw2fHx8fHx8Mnx8MTcxMTczODE2OHw&ixlib=rb-4.0.3&q=80&w=1080",
                                  pictooChats: [PictooChatModel.chat1, PictooChatModel.chat2, PictooChatModel.chat3, PictooChatModel.chat4])
    static let kate = FriendModel(name: "Kate",
                                  avatar: "https://images.unsplash.com/photo-1711539924834-06816347ff2a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NzU3Mjd8MHwxfGFsbHw4fHx8fHx8Mnx8MTcxMTczODE2OHw&ixlib=rb-4.0.3&q=80&w=1080",
                                  pictooChats: [PictooChatModel.chat2, PictooChatModel.chat4, PictooChatModel.chat3, PictooChatModel.chat1])
#endif
}
