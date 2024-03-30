//
//  LongPressCircleView.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 30/03/2024.
//

import SwiftUI

struct ChatCircle: Identifiable {
    let id: UUID = UUID()
    var position: CGPoint
    var text: String = ""
}

struct PopoverContent: View {
    var circleChat: ChatCircle
    var onSubmit: (String) -> Void
    @State private var inputText: String = ""
    
    var body: some View {
        VStack {
            if !circleChat.text.isEmpty {
                Text(circleChat.text)
                    .padding()
            } else {
                TextField("Enter text here", text: $inputText, onCommit: {
                    submitText()
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            }
        }
    }
    
    private func submitText() {
        onSubmit(inputText)
        inputText = ""
    }
}


struct LongPressCircleView: View {
    @State private var circles: [ChatCircle] = []
    @State private var activePopoverId: UUID?
    
    var body: some View {
        ZStack {
            VStack {
                Color.blue
                    .onLongPressGesture { location in
                        let newCircle = ChatCircle(position: location)
                        print("location \(location)")
                        circles.append(newCircle)
                        activePopoverId = nil
                    }
                Color.green
            }
            
            ForEach(circles, id: \.id) { circle in
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.red)
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

struct LongPressCircleView_Previews: PreviewProvider {
    static var previews: some View {
        LongPressCircleView()
    }
}

