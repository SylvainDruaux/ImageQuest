//
//  PhotoResponseDTOStub.swift
//  ImageQuestTests
//
//  Created by Sylvain Druaux on 04/04/2024.
//

import Foundation
@testable import ImageQuest

extension PhotoResponseDTO {
    static func stub(
        id: String = UUID().uuidString,
        createdAt: Date = Date(timeIntervalSince1970: TimeInterval.random(in: 0...(Date().timeIntervalSince1970))),
        width: Int = 6000,
        height: Int = 4000,
        description: String = "Just a beautiful landscape",
        altDescription: String? = nil,
        urls: ImageQuest.Urls = .init(raw: "", full: "", regular: "", small: "", thumb: "", smallS3: ""),
        links: Links = .init(download: ""),
        user: User = .init(id: UUID().uuidString, name: "Alex Smith"),
        exif: Exif? = nil,
        location: Location? = nil
    ) -> Self {
        .init(
            id: id,
            createdAt: createdAt,
            width: width,
            height: height,
            description: description,
            altDescription: altDescription,
            urls: urls,
            links: links,
            user: user,
            exif: exif,
            location: location
        )
    }
    
    static var firstPhoto: Self {
        .stub(description: "First photo")
    }
    
    static var secondPhoto: Self {
        .stub(
            description: "Second photo",
            exif: .init(make: "Canon", model: "Canon EOS 6D", exposureTime: "1/800", aperture: 3.2, focalLength: 24.0, iso: 100),
            location: .init(
                name: "Rio de Janeiro, Brazil",
                city: "Rio de Janeiro",
                country: "Brazil",
                position: .init(latitude: -22.9068, longitude: -43.1729)
            )
        )
    }
    
    static var thirdPhoto: Self {
        .stub(description: "Third photo")
    }
}
