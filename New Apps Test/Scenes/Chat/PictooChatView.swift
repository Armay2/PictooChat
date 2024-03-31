//
//  PictooChatView.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 29/03/2024.
//

import SwiftUI

struct Message: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isCurrentUser: Bool
}

class PictooChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var newMessageText = ""
    
    func sendMessage() {
        let newMessage = Message(text: newMessageText, isCurrentUser: true)
        let fakeResponce = Message(text: "Hey this is my answer !", isCurrentUser: false)
        messages.append(newMessage)
        messages.append(fakeResponce)
        newMessageText = ""
    }
}

struct PictooChatView: View {
    @StateObject private var viewModel = PictooChatViewModel()
    @State private var isChatSheetPresented = false
    @State private var isPictooComVisible = true
    var pictooChat: PictooChat
    
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
            ChatView(viewModel: viewModel)
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
        pictooChat.messages.append("New message")
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
