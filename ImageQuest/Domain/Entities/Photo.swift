//
//  Photo.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 04/04/2024.
//

import Foundation

struct Photo: Equatable, Identifiable, Hashable {
    let id: String
    let published: Date
    let width: Int
    let height: Int
    let description: String?
    let altDescription: String?
    let urls: PhotoURLs
    let downloadLink: String
    let photographer: Photographer
    let exif: PhotoExif?
    let location: PhotoLocation?
}

struct PhotoURLs: Equatable, Hashable {
    let raw: URL?
    let full: URL?
    let regular: URL?
    let small: URL?
    let thumb: URL?
    let smallS3: URL?
}

struct PhotoExif: Equatable, Hashable {
    typealias FractionOfSecond = String
    typealias Millimeter = Double
    
    let make: String
    let model: String
    let shutterSpeed: FractionOfSecond
    let aperture: Double
    let focalLength: Millimeter
    let iso: Int
}

struct PhotoLocation: Equatable, Hashable {
    let name: String
    let city: String
    let country: String
    let position: PhotoPosition
}

struct PhotoPosition: Equatable, Hashable {
    let latitude: Double
    let longitude: Double
}

struct PhotosPage: Equatable {
    let totalPages: Int?
    let photos: [Photo]
}

extension Photo {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
