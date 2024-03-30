//
//  GalleryView.swift
//  New Apps Test
//
//  Created by Arnaud Nommay on 29/03/2024.
//

import SwiftUI

struct GalleryView: View {
    var imageService = UnsplashService()
    @State var images: [URL] = []
    let columns = [GridItem(.fixed(100)), GridItem(.fixed(100))]
    
    
    let gridLayout = [
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 40))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                ForEach(images, id: \.self) { url in
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .cornerRadius(10)
                    } placeholder: {
                        ZStack {
                            ProgressView()
                            Rectangle()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(.gray).opacity(0.2)
                        }
                    }
                }
            }
            .padding(10)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Mike")
        .task {
            let urls = await imageService.getFeaturedPhotos()
            images = urls.map { URL(string: $0)! }
                .shuffled()
        }
    }
}

#Preview {
    GalleryView()
}
