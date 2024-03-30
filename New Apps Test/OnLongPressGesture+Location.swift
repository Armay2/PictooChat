//
//  OnLongPressGesture+Location.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 30/03/2024.
//

import SwiftUI
import UIKit

// A modified version of the original UIViewRepresentable to support long press gestures
struct LongPressLocatingView: UIViewRepresentable {
    // Configuration for the long press gesture
    var minimumPressDuration: TimeInterval = 0.5 // Default long press duration
    var allowableMovement: CGFloat = 10 // Default movement tolerance
    
    var onLongPress: (CGPoint) -> Void // Closure to call when a long press is detected
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.isUserInteractionEnabled = true
        view.backgroundColor = .clear // Make the UIView transparent
        
        // Configure the long press gesture recognizer
        let longPressRecognizer = UILongPressGestureRecognizer(target: context.coordinator,
                                                                action: #selector(context.coordinator.handleLongPress(_:)))
        longPressRecognizer.minimumPressDuration = minimumPressDuration
        longPressRecognizer.allowableMovement = allowableMovement
        view.addGestureRecognizer(longPressRecognizer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // UIView update logic can be implemented here if needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onLongPress: onLongPress)
    }
    
    // Coordinator to act as a bridge between the UIKit and SwiftUI worlds
    class Coordinator: NSObject {
        var onLongPress: (CGPoint) -> Void
        
        init(onLongPress: @escaping (CGPoint) -> Void) {
            self.onLongPress = onLongPress
        }
        
        @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
            if gesture.state == .began {
                let location = gesture.location(in: gesture.view)
                onLongPress(location)
            }
        }
    }
}

// A SwiftUI view modifier that overlays a view with the long press detecting UIView
struct LongPressLocator: ViewModifier {
    var minimumPressDuration: TimeInterval = 0.5
    var allowableMovement: CGFloat = 10
    let perform: (CGPoint) -> Void
    
    func body(content: Content) -> some View {
        content
            .overlay(
                LongPressLocatingView(minimumPressDuration: minimumPressDuration,
                                       allowableMovement: allowableMovement,
                                       onLongPress: perform)
            )
    }
}

// An extension to View to easily apply the long press locator
extension View {
    func onLongPressGesture(minimumPressDuration: TimeInterval = 0.5, allowableMovement: CGFloat = 10, perform: @escaping (CGPoint) -> Void) -> some View {
        self.modifier(LongPressLocator(minimumPressDuration: minimumPressDuration, allowableMovement: allowableMovement, perform: perform))
    }
}

