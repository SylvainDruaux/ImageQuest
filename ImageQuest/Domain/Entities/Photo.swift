//
//  Photo.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 04/04/2024.
//

import Foundation

struct Photo: Equatable, Identifiable, Hashable, ColumnLayoutItem {
    let id: String
    let published: Date
    let width: Int
    let height: Int
    let description: String?
    let altDescription: String?
    let urls: PhotoURLs
    let links: PhotoLinks
    let photographer: Photographer
    let exif: PhotoExif?
    let location: PhotoLocation?
    var size: CGSize { return CGSize(width: width, height: height) }
}

struct PhotoURLs: Equatable, Hashable {
    let raw: URL?
    let full: URL?
    let regular: URL?
    let small: URL?
    let thumb: URL?
    let smallS3: URL?
}

struct PhotoLinks: Equatable, Hashable {
    let html: URL?
    let download: URL?
}

struct PhotoExif: Equatable, Hashable {
    typealias FractionOfSecond = String
    typealias Millimeter = String
    
    let make: String
    let model: String
    let shutterSpeed: FractionOfSecond
    let aperture: String
    let focalLength: Millimeter
    let iso: String
}

struct PhotoLocation: Equatable, Hashable {
    let name: String?
    let position: PhotoPosition?
}

struct PhotoPosition: Equatable, Hashable {
    let latitude: Double?
    let longitude: Double?
}

struct PhotosPage: Equatable {
    let totalPages: Int
    let photos: [Photo]
}

extension Photo {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
