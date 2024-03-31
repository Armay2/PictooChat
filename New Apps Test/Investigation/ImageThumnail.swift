//
//  ImageThumnail.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 29/03/2024.
//

import SwiftUI
import Observation

struct PictooGallery: View {
    let pictooChats: [PictooChatModel]
    let gridLayout = [
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 40))
    ]
    
    @Namespace var namespace
    @State private var showDetail = false
    
    @State var selectedChat: PictooChatModel?
    @State var selectedImage: Image?
    
    var body: some View {
        ZStack {
            if showDetail {

            } else {
                ScrollView {
                    LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                        ForEach(pictooChats) { pictooChat in
                            AsyncImage(url: pictooChat.imageURL) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
//                                    .matchedGeometryEffect(id: "image", in: namespace)
                                    .frame(width: 100)
                            } placeholder: {
                                LoadingImageView()
                                    .frame(width: 100)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct ImageThumnail: View {
    let image = Image(systemName: "gear")
    @State private var show = false
    @Namespace var namespace

    var body: some View {
        ZStack {
            if show {
                VStack {
                    image
                        .resizable()
                        .scaledToFill()
                        .matchedGeometryEffect(id: "image", in: namespace)
                        .frame(maxHeight: 400)
                    Spacer()
                }
                .background(Color.blue.matchedGeometryEffect(id: "back", in: namespace))
            } else {
                VStack {
                    image
                        .resizable()
                        .scaledToFit()
                        .matchedGeometryEffect(id: "image", in: namespace)
                        .frame(width: 100)
                }
                .background(Color.red.matchedGeometryEffect(id: "back", in: namespace))
            }
        }
        .onTapGesture {
            withAnimation() {
                show.toggle()
            }
        }
    }
}

#Preview {
    PictooGallery(pictooChats: [PictooChatModel.chat1,
                                PictooChatModel.chat2,
                                PictooChatModel.chat3,
                                PictooChatModel.chat4])
}
