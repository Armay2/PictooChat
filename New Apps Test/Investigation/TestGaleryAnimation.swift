//
//  TestGaleryAnimation.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 29/03/2024.
//

import SwiftUI

struct TestGaleryAnimation: View {
    @State private var selectedImage: String?
    @Namespace private var namespace
    private let images = ["gear", "pencil", "square.and.arrow.up.on.square.fill", "externaldrive.fill.badge.checkmark", "truck.box"]
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        ZStack {
            if let image = selectedImage {
                selectedImageView(for: image)
            } else {
                gridView
            }
        }
    }
    
    private var gridView: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns) {
                ForEach(images, id: \.self) { image in
                    imageThumbnailView(for: image)
                }
            }
            .padding(10)
        }
    }
    
    private func imageThumbnailView(for image: String) -> some View {
        VStack {
            Image(systemName: image)
                .resizable()
                .matchedGeometryEffect(id: image, in: namespace)
                .frame(height: 100)
                .cornerRadius(10)
        }
        .background(Color.clear.matchedGeometryEffect(id: "back + \(image)", in: namespace))
        .onTapGesture {
            withAnimation {
                selectedImage = image
            }
        }
    }
    
    private func selectedImageView(for image: String) -> some View {
        VStack {
            Image(systemName: image)
                .resizable()
                .matchedGeometryEffect(id: image, in: namespace)
                .frame(maxHeight: 400)
                .onTapGesture {
                    withAnimation {
                        selectedImage = nil
                    }
                }
            Spacer()
        }
        .background(Color.red.matchedGeometryEffect(id: "back + \(image)", in: namespace))
        .ignoresSafeArea()
    }}

struct TestGaleryAnimation_Previews: PreviewProvider {
    static var previews: some View {
        TestGaleryAnimation()
    }
}
