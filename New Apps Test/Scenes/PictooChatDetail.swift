//
//  PictooChatDetail.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 29/03/2024.
//

import SwiftUI

struct PictooChatDetail: View {
    let image: Image
    let pictooChat: PictooChat
    var namespace: Namespace.ID
    let closeChat: () -> ()
    
    var body: some View {
        VStack {
            image
                .resizable()
                .scaledToFill()
                .matchedGeometryEffect(id: "image", in: namespace)
                .frame(height: 400)
            Spacer()
        }
        .background(Color.red.matchedGeometryEffect(id: "background", in: namespace))
        .frame(maxWidth: .infinity)
        .ignoresSafeArea()
        
    }
}

struct PictooChatDetail_Previews: PreviewProvider {
    @Namespace static var namespace
    static let image = Image(systemName: "gear")
    
    static var previews: some View {
        PictooChatDetail(image: image,
                         pictooChat: PictooChat.chat1,
                         namespace: namespace, closeChat: {})
    }
}
