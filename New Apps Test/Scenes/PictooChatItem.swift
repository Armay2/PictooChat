//
//  PictooChatItem.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 29/03/2024.
//

import SwiftUI

struct PictooChatItem: View {
    var image: Image
    var namespace: Namespace.ID
    
    var body: some View {
        VStack {
            image
                .resizable()
                .scaledToFit()
                .matchedGeometryEffect(id: "image", in: namespace)
                .frame(height: 100)
        }
        .background(Color.blue.matchedGeometryEffect(id: "background", in: namespace))
    }
}

struct PictooChatItem_Previews: PreviewProvider {
    @Namespace static var namespace
    static let image = Image(systemName: "gear")
    
    static var previews: some View {
        PictooChatItem(image:image, namespace: namespace)
    }
}
