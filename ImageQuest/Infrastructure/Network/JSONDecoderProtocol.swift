//
//  JSONDecoderProtocol.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 03/04/2024.
//

import Foundation

protocol JSONDecoderProtocol {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}
