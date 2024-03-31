//
//  ChatBubbleView.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 30/03/2024.
//

import SwiftUI

enum ChatBubbleDirection {
    case left
    case right
    
    var color: Color {
        switch self {
        case .left:
                .black
        case .right:
                .blue
        }
    }
    
    var alignment: Alignment {
        switch self {
        case .left:
            return .bottomLeading
        case .right:
            return .bottomTrailing
        }
    }
    
    var rotationDegrees: Double {
        switch self {
        case .left:
            return 65
        case .right:
            return -65
        }
    }
    
    var offset: CGSize {
        switch self {
        case .left:
            return CGSize(width: -10, height: 7)
        case .right:
            return CGSize(width: 10, height: 7)
        }
    }
}

struct ChatBubbleView: View {
    let message: String
    let direction: ChatBubbleDirection
    
    var body: some View {
        Text(message)
            .padding(12)
            .foregroundStyle(.white)
            .background(direction.color)
            .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
            .overlay(alignment: direction.alignment) {
                ChatBubbleArrow(direction: direction)
            }
    }
    
    @ViewBuilder
    private func ChatBubbleArrow(direction: ChatBubbleDirection) -> some View {
        Image(systemName: "arrowtriangle.down.fill")
            .font(.title)
            .rotationEffect(.degrees(direction.rotationDegrees))
            .offset(direction.offset)
            .foregroundColor(direction.color)
    }
}


#Preview {
    ChatBubbleView(message: "message", direction: .right)
}
