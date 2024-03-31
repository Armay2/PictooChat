//
//  PictooChatModel.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 31/03/2024.
//

import Foundation
import Observation

@Observable
class PictooChatModel: Identifiable {
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
    static let chat1 = PictooChatModel(imageURL: URL(string: "https://images.unsplash.com/photo-1683009427042-e094996f9780?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NzU3Mjd8MXwxfGFsbHwxfHx8fHx8Mnx8MTcxMTczODE2OHw&ixlib=rb-4.0.3&q=80&w=1080")!,
                                  messages: [],
                                  chatCircle: [])
    static let chat2 = PictooChatModel(imageURL: URL(string: "https://images.unsplash.com/photo-1711539924834-06816347ff2a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NzU3Mjd8MHwxfGFsbHw4fHx8fHx8Mnx8MTcxMTczODE2OHw&ixlib=rb-4.0.3&q=80&w=1080")!,
                                  messages: [],
                                  chatCircle: [])
    static let chat3 = PictooChatModel(imageURL: URL(string: "https://images.unsplash.com/photo-1711627295683-d73c279604f7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NzU3Mjd8MHwxfGFsbHwxMHx8fHx8fDJ8fDE3MTE3MzgxNjh8&ixlib=rb-4.0.3&q=80&w=1080")!,
                                  messages: [],
                                  chatCircle: [])
    static let chat4 = PictooChatModel(imageURL: URL(string: "https://images.unsplash.com/photo-1711654106922-f44ee5df26ba?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NzU3Mjd8MHwxfGFsbHw0fHx8fHx8Mnx8MTcxMTczODE2OHw&ixlib=rb-4.0.3&q=80&w=1080")!,
                                  messages: [],
                                  chatCircle: [])
#endif
}
