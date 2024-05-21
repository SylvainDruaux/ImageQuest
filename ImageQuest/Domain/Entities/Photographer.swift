//
//  Photographer.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 04/04/2024.
//

import Foundation

struct Photographer: Equatable, Identifiable, Hashable {
    let id: String
    let name: String
}

extension Photographer {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
