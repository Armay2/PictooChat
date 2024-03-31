//
//  Message.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 31/03/2024.
//

import Foundation

struct Message: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isCurrentUser: Bool
}
