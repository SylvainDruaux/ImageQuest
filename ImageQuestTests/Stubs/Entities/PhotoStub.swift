//
//  PhotoStub.swift
//  ImageQuestTests
//
//  Created by Sylvain Druaux on 04/04/2024.
//

import Foundation
@testable import ImageQuest

extension Photo {
    static func stub(
        id: String = UUID().uuidString,
        published: Date = Date(timeIntervalSince1970: TimeInterval.random(in: 0...(Date().timeIntervalSince1970))),
        width: Int = 6000,
        height: Int = 4000,
        description: String = "Just a beautiful landscape",
        altDescription: String? = nil,
        urls: PhotoURLs = .init(raw: nil, full: nil, regular: nil, small: nil, thumb: nil, smallS3: nil),
        downloadLink: String = "https://example.com/download",
        photographer: Photographer = .init(id: UUID().uuidString, name: "Alex Smith"),
        exif: PhotoExif? = nil,
        location: PhotoLocation? = nil
    ) -> Self {
        .init(
            id: id,
            published: published,
            width: width,
            height: height,
            description: description,
            altDescription: altDescription,
            urls: urls,
            downloadLink: downloadLink,
            photographer: photographer,
            exif: exif,
            location: location
        )
    }
    
    static var firstPhoto: Self {
        .stub(description: "First photo")
    }
    
    static var secondPhoto: Self {
        .stub(description: "Second photo")
    }
    
    static var thirdPhoto: Self {
        .stub(description: "Third photo")
    }
}

extension PhotosPage {
    static var stub: Self {
        .init(
            totalPages: 1, 
            photos: [.firstPhoto, .secondPhoto, .thirdPhoto]
        )
    }
}
