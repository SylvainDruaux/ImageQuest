//
//  PhotoPageableListDTOStub.swift
//  ImageQuestTests
//
//  Created by Sylvain Druaux on 04/04/2024.
//

import Foundation
@testable import ImageQuest

extension PhotoPageableListDTO {
    static var stub: Self {
        .init(
            results: [.firstPhoto, .secondPhoto, .thirdPhoto],
            totalPages: 10
        )
    }
}
