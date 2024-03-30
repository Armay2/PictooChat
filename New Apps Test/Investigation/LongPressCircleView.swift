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
    let text: String
    
    var body: some View {
        Text(text)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
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
                             attachmentAnchor: .rect(.rect(CGRect(x: circle.position.x, y: circle.position.y, width: 0, height: 0)))) {
                        PopoverContent(text: circle.id.uuidString)
                             .presentationCompactAdaptation(.popover)
                     }
            }
        }
        
    }
}

struct LongPressCircleView_Previews: PreviewProvider {
    static var previews: some View {
        LongPressCircleView()
    }
}

