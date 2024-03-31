//
//  ChatView.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 30/03/2024.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel: PictooChatViewModel

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
            
            HStack {
                TextField("Type a message...", text: $viewModel.newMessageText)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        viewModel.sendMessage()
                    }
                Button(action: {
                    viewModel.sendMessage()
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
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
    ChatView(viewModel: PictooChatViewModel())
}
