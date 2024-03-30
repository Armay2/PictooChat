//
//  LoadingImageView.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 30/03/2024.
//

import SwiftUI

struct LoadingImageView: View {
    var body: some View {
        ZStack {
            ProgressView()
            RoundedRectangle(cornerRadius: 16.0)
                .foregroundStyle(.gray).opacity(0.2)
        }
    }
}

#Preview {
    LoadingImageView()
}
