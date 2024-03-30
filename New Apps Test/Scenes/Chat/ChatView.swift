//
//  ChatView.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 30/03/2024.
//

import SwiftUI

struct Message: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isCurrentUser: Bool
}

@Observable
class ChatViewModel: ObservableObject {
    var messages: [Message] = []
    var newMessageText = ""
    
    func sendMessage() {
        let newMessage = Message(text: newMessageText, isCurrentUser: true)
        let fakeResponce = Message(text: "Hey this is my answer !", isCurrentUser: false)
        messages.append(newMessage)
        messages.append(fakeResponce)
        newMessageText = ""
    }
}

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { scrollView in
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(viewModel.messages) { message in
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
                    .onChange(of: viewModel.messages) {
                        scrollToLastMessage(with: scrollView)
                    }
                    .onAppear {
                        scrollToLastMessage(with: scrollView)
                    }
                }
            }
            
            // Message input field
            HStack {
                TextField("Type a message...", text: $viewModel.newMessageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onSubmit {
                        viewModel.sendMessage()
                    }
                Button(action: {
                    viewModel.sendMessage()
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(viewModel.newMessageText.isEmpty ? .gray : .blue)
                }
                .disabled(viewModel.newMessageText.isEmpty)
            }
            .padding()
        }
        .padding(.top)
    }
    
    private func scrollToLastMessage(with scrollView: ScrollViewProxy) {
        if let lastMessage = viewModel.messages.last {
            scrollView.scrollTo(lastMessage.id, anchor: .bottom)
        }
    }
}




#Preview {
    ChatView()
}
