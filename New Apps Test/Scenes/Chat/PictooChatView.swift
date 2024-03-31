//
//  PictooChatView.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 29/03/2024.
//

import SwiftUI

struct PictooChatView: View {
    @State private var isChatSheetPresented = false
    @State private var isPictooComVisible = true
    let pictooChat: PictooChat
    
    var body: some View {
        VStack {
            PictooView(pictooChat: pictooChat)
            Spacer()
        }
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
            ChatView()
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
            isPictooComVisible.toggle()
        }) {
            VStack {
                Image(systemName: isPictooComVisible ? "eye.slash.fill" : "eye.fill")
                Text(isPictooComVisible ? "Hide" : "Show")
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
        // Implement the cleaning logic here
    }
}

struct PictooChatDetail_Previews: PreviewProvider {
    static let image = Image(systemName: "gear")
    
    static var previews: some View {
        NavigationStack {
            PictooChatView(pictooChat: PictooChat.chat2)
        }
    }
}
