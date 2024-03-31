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
    @GestureState private var zoom = 1.0

    var body: some View {
        ZStack {
            AsyncImage(url: pictooChat.imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .scaleEffect(zoom)
                    .gesture(
                        MagnifyGesture()
                            .updating($zoom) { value, gestureState, transaction in
                                gestureState = value.magnification
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
        }
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
