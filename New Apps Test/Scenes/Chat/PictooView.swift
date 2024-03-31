//
//  PictooView.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 31/03/2024.
//

import SwiftUI

struct PictooView: View {
    let pictooChat: PictooChat

    @State private var circles: [ChatCircle] = []
    @State private var activePopoverId: UUID?
    
    var body: some View {
        ZStack {
            AsyncImage(url: pictooChat.imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            } placeholder: {
                LoadingImageView()
                    .frame(maxWidth: .infinity, maxHeight: 400)
            }
            .onLongPressGesture { location in
                let newCircle = ChatCircle(position: location)
                circles.append(newCircle)
                activePopoverId = nil
            }
            
            ForEach(circles, id: \.id) { circle in
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
    }
    
    //TODO: Change that logic: it's not suitable !
    private func circleChatSend(text: String, circle: ChatCircle) {
        guard let oldCircle = circles.first(where: { $0.id == circle.id }) else {
            return
        }
        
        circles.removeAll(where: {$0.id == oldCircle.id})
        let new = ChatCircle(position: oldCircle.position, text: text)
        circles.append(new)
    }
}

#Preview {
    PictooView(pictooChat: PictooChat.chat2)
}
