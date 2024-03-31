//
//  PictooView.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 31/03/2024.
//

import SwiftUI

struct PictooView: View {
    let areChatCirclesVisible: Bool
    var pictooChat: PictooChat
    
    @State private var activePopoverId: UUID?
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        ScrollView([.horizontal], showsIndicators: false) {
            ZStack {
                AsyncImage(url: pictooChat.imageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .scaleEffect(scale) // Apply the dynamic scale factor
                        .gesture(
                            MagnificationGesture()
                                .onChanged { value in
                                    // Update the scale factor based on the gesture's progress
                                    scale = value
                                }
                        )
                } placeholder: {
                    LoadingImageView()
                        .frame(maxWidth: .infinity, maxHeight: 400)
                }
                .onLongPressGesture { location in
                    let newCircle = ChatCircle(position: location)
                    pictooChat.chatCircle.append(newCircle)
                    activePopoverId = nil
                }
                
                if areChatCirclesVisible {
                    chatCircles
                }
            }.edgesIgnoringSafeArea(.top)
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    private var chatCircles: some View {
        ForEach(pictooChat.chatCircle, id: \.id) { circle in
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .position(circle.position)
                .onTapGesture {
                    activePopoverId = circle.id
                }
                .popover(isPresented: .constant(activePopoverId == circle.id),
                         attachmentAnchor: .rect(.rect(CGRect(x: circle.position.x,
                                                              y: circle.position.y,
                                                              width: 0,
                                                              height: 0)))) {
                    PopoverContent(circleChat: circle) { text in
                        circleChatSend(text: text, circle: circle)
                    }
                    .onDisappear {
                        activePopoverId = nil
                    }
                    .presentationCompactAdaptation(.popover)
                }
        }
    }
    
    //TODO: Change that logic: it's not suitable !
    private func circleChatSend(text: String, circle: ChatCircle) {
        guard let oldCircle = pictooChat.chatCircle.first(where: { $0.id == circle.id }) else {
            return
        }
        
        pictooChat.chatCircle.removeAll(where: {$0.id == oldCircle.id})
        let new = ChatCircle(position: oldCircle.position, text: text)
        pictooChat.chatCircle.append(new)
        
        let newMessage = Message(text: text, isCurrentUser: true)
        pictooChat.messages.append(newMessage)
    }
}

#Preview {
    PictooView(areChatCirclesVisible: true, pictooChat: PictooChat.chat2)
}
