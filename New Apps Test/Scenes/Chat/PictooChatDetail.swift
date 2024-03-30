//
//  PictooChatDetail.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 29/03/2024.
//

import SwiftUI

struct PictooChatDetail: View {
    @State private var showingSheet = false
    let pictooChat: PictooChat
    
    var body: some View {
        VStack {
            AsyncImage(url: pictooChat.imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            } placeholder: {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 400)
            }
            Spacer()
        }
        .background(.white)
        .frame(maxWidth: .infinity)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Spacer()
                Button(action: {
                    self.showingSheet = true
                }) {
                    Image(systemName: "message")
                }
            }
        }
        .sheet(isPresented: $showingSheet) {
            ChatView()
                .presentationDetents([.medium, .large])
        }
    }
}

struct PictooChatDetail_Previews: PreviewProvider {
    @Namespace static var namespace
    static let image = Image(systemName: "gear")
    
    static var previews: some View {
        NavigationStack {
            PictooChatDetail(pictooChat: PictooChat.chat1)
        }
    }
}
