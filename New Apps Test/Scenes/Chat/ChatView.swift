//
//  ChatView.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 30/03/2024.
//

import SwiftUI

struct ChatView: View {
    var pictooChat: PictooChat
    @State var typingMessage: String = ""
    
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { scrollView in
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(pictooChat.messages) { message in
                            HStack {
                                if message.isCurrentUser {
                                    Spacer()
                                    ChatBubbleView(message: message.text, direction: .right)
                                } else {
                                    ChatBubbleView(message: message.text, direction: .left)
                                    Spacer()
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .onChange(of: pictooChat.messages) {
                        scrollToLastMessage(with: scrollView)
                    }
                    .onAppear {
                        scrollToLastMessage(with: scrollView)
                    }
                }
            }
            
            HStack {
                TextField("Type a message...", text: $typingMessage)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        sendMessage()
                    }
                Button(action: {
                    sendMessage()
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(typingMessage.isEmpty ? .gray : .blue)
                }
                .disabled(typingMessage.isEmpty)
            }
            .padding()
        }
        .padding(.top)
    }
    
    private func sendMessage() {
        let newMessage = Message(text: typingMessage, isCurrentUser: true)
        let fakeResponce = Message(text: "Hey this is my answer !", isCurrentUser: false)
        pictooChat.messages.append(newMessage)
        pictooChat.messages.append(fakeResponce)
        typingMessage = ""
    }
    
    private func scrollToLastMessage(with scrollView: ScrollViewProxy) {
        if let lastMessage = pictooChat.messages.last {
            scrollView.scrollTo(lastMessage.id, anchor: .bottom)
        }
    }
}




#Preview {
    ChatView( pictooChat: PictooChat.chat1)
}
