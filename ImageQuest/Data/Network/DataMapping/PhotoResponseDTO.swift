//
//  PhotoResponseDTO.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 04/04/2024.
//

import Foundation

struct PhotoResponseDTO: Identifiable, Decodable {
    let id: String
    let createdAt: Date
    let width, height: Int
    let description: String?
    let altDescription: String?
    let urls: Urls
    let links: Links
    let user: User
    let exif: Exif?
    let location: Location?
}

struct Urls: Decodable {
    let raw, full, regular, small: String
    let thumb, smallS3: String
    
    func toDomain() -> PhotoURLs {
        .init(
            raw: URL(string: raw),
            full: URL(string: full),
            regular: URL(string: regular),
            small: URL(string: small),
            thumb: URL(string: thumb),
            smallS3: URL(string: smallS3)
        )
    }
}

struct Links: Decodable {
    let html: String
    let download: String
    
    func toDomain() -> PhotoLinks {
        .init(
            html: URL(string: html),
            download: URL(string: download)
        )
    }
}

struct User: Decodable {
    let id: String
    let name: String
    
    func toDomain() -> Photographer {
        .init(id: id, name: name)
    }
}

struct Exif: Decodable {
    let make, model, exposureTime, aperture, focalLength: String?
    let iso: Int?
    
    func toDomain() -> PhotoExif {
        .init(
            make: make ?? "-",
            model: model ?? "-",
            shutterSpeed: exposureTime ?? "-",
            aperture: aperture ?? "-",
            focalLength: (focalLength != nil && focalLength != "0.0") ? focalLength! : "-",
            iso: iso.map { String($0) } ?? "-"
        )
    }
}

struct Location: Decodable {
    let name: String?
    let position: Position?
    
    func toDomain() -> PhotoLocation {
        .init(
            name: name,
            position: position?.toDomain()
        )
    }
}

struct Position: Decodable {
    let latitude, longitude: Double?
    
    func toDomain() -> PhotoPosition {
        .init(latitude: latitude, longitude: longitude)
    }
}

extension PhotoResponseDTO {
    func toDomain() -> Photo {
        .init(
            id: id,
            published: createdAt,
            width: width,
            height: height,
            description: description,
            altDescription: altDescription,
            urls: urls.toDomain(),
            links: links.toDomain(),
            photographer: user.toDomain(),
            exif: exif?.toDomain(),
            location: location?.toDomain()
        )
    }
}
