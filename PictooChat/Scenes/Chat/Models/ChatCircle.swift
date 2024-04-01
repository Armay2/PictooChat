//
//  ChatCircle.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 31/03/2024.
//

import Foundation

struct ChatCircle: Identifiable {
    let id: UUID = UUID()
    var position: CGPoint
    var text: String = ""
}
