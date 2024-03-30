//
//  ImageThumnail.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 29/03/2024.
//

import SwiftUI

struct PictooChat: Identifiable {
    let id = UUID()
    let imageURL: URL
    let messages: [String]
    
#if DEBUG
    static let chat1 = PictooChat(imageURL: URL(string: "https://images.unsplash.com/photo-1683009427042-e094996f9780?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NzU3Mjd8MXwxfGFsbHwxfHx8fHx8Mnx8MTcxMTczODE2OHw&ixlib=rb-4.0.3&q=80&w=1080")!,
                                  messages: ["message"])
    static let chat2 = PictooChat(imageURL: URL(string: "https://images.unsplash.com/photo-1711539924834-06816347ff2a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NzU3Mjd8MHwxfGFsbHw4fHx8fHx8Mnx8MTcxMTczODE2OHw&ixlib=rb-4.0.3&q=80&w=1080")!,
                                  messages: ["message"])
    static let chat3 = PictooChat(imageURL: URL(string: "https://images.unsplash.com/photo-1711627295683-d73c279604f7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NzU3Mjd8MHwxfGFsbHwxMHx8fHx8fDJ8fDE3MTE3MzgxNjh8&ixlib=rb-4.0.3&q=80&w=1080")!,
                                  messages: ["message"])
    static let chat4 = PictooChat(imageURL: URL(string: "https://images.unsplash.com/photo-1711654106922-f44ee5df26ba?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NzU3Mjd8MHwxfGFsbHw0fHx8fHx8Mnx8MTcxMTczODE2OHw&ixlib=rb-4.0.3&q=80&w=1080")!,
                                  messages: ["message"])
#endif
}

struct PictooGallery: View {
    
    let pictooChats: [PictooChat]
    let gridLayout = [
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 40))
    ]
    
    @Namespace var namespace
    @State private var showDetail = false
    
    @State var selectedChat: PictooChat?
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
                                Rectangle()
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
    PictooGallery(pictooChats: [PictooChat.chat1,
                                PictooChat.chat2,
                                PictooChat.chat3,
                                PictooChat.chat4])
//        ImageThumnail()
}
