//
//  PageableListResponseDTO.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 04/04/2024.
//

import Foundation

/// A pageable list of items.
struct PageableListResponseDTO<Result: Decodable & Identifiable>: Decodable {
    let results: [Result]
    let totalPages: Int?
}

/// A pageable list of photos.
typealias PhotoPageableListDTO = PageableListResponseDTO<PhotoResponseDTO>

extension PhotoPageableListDTO {
    func toDomain() -> PhotosPage {
        .init(
            totalPages: totalPages ?? 1,
            photos: results.map { $0.toDomain() }
        )
    }
}
