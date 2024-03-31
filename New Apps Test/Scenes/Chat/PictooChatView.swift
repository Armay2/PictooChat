//
//  PictooChatView.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 29/03/2024.
//

import SwiftUI

struct PictooChatView: View {
    @State private var isChatSheetPresented = false
    @State private var areChatCirclesVisible = true
    @State var pictooChat: PictooChatModel
    
    var body: some View {
        PictooView(areChatCirclesVisible: areChatCirclesVisible, pictooChat: pictooChat)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                cleanButton
                Spacer()
                toggleVisibilityButton
                Spacer()
                chatButton
            }
        }
        .sheet(isPresented: $isChatSheetPresented) {
            ChatView(pictooChat: pictooChat)
                .presentationDetents([.medium, .large])
        }
    }
    
    private var cleanButton: some View {
        Button(action: clearPictooCom) {
            VStack {
                Image(systemName: "eraser.fill")
                Text("Clean")
            }
        }
    }
    
    private var toggleVisibilityButton: some View {
        Button(action: {
            areChatCirclesVisible.toggle()
        }) {
            VStack {
                Image(systemName: areChatCirclesVisible ? "eye.slash.fill" : "eye.fill")
                Text(areChatCirclesVisible ? "Hide" : "Show")
            }
        }
    }
    
    private var chatButton: some View {
        Button(action: {
            isChatSheetPresented = true
        }) {
            VStack {
                Image(systemName: "message.fill")
                Text("Chat")
            }
        }
    }
    
    private func clearPictooCom() {
        pictooChat.chatCircle.removeAll()
    }
}

#if DEBUG
struct PictooChatDetail_Previews: PreviewProvider {    
    static var previews: some View {
        NavigationStack {
            PictooChatView(pictooChat: PictooChatModel.chat2)
        }
    }
}
#endif
