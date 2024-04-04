//
//  JSONDecoder+Ext.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 03/04/2024.
//

import Foundation

extension JSONDecoder: JSONDecoderProtocol {
    static var convertFromSnakeCase: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
