//
//  PhotoStub.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 04/04/2024.
//

#if DEBUG
import Foundation

extension Photo {
    static func stub(
        id: String = UUID().uuidString,
        published: Date = Date(timeIntervalSince1970: TimeInterval.random(in: 0...(Date().timeIntervalSince1970))),
        width: Int = 6000,
        height: Int = 4000,
        description: String = "Just a beautiful landscape",
        altDescription: String? = nil,
        urls: PhotoURLs = .init(raw: nil, full: nil, regular: nil, small: nil, thumb: nil, smallS3: nil),
        links: PhotoLinks = .init(html: URL(string: "https://example.com/"), download: URL(string: "https://example.com/download")),
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
            links: links,
            photographer: photographer,
            exif: exif,
            location: location
        )
    }
    
    static var firstPhoto: Self {
        .stub(
            id: "exFdOWkYBQw",
            published: {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                return dateFormatter.date(from: "2019-12-30") ?? Date()
            }(),
            description: "beach and cliffs in Nusa Penida",
            urls: PhotoURLs(
                raw: nil,
                full: URL(string: "https://images.unsplash.com/photo-1577717903315-1691ae25ab3f"),
                regular: URL(string: "https://images.unsplash.com/photo-1577717903315-1691ae25ab3f"),
                small: nil,
                thumb: nil,
                smallS3: nil
            ),
            photographer: Photographer(id: "", name: "Alfiano Sutianto"),
            exif: PhotoExif(make: "SONY", model: "ILCE-6300", shutterSpeed: "1/4000", aperture: "3.5", focalLength: "16.0", iso: "250"),
            location: PhotoLocation(
                name: "Nusa Penida, Klungkung Regency, Bali, Indonesia",
                position: PhotoPosition(latitude: -8.727807, longitude: 115.5444231)
            )
        )
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
#endif
