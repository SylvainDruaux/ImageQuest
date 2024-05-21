//
//  StatusResponse.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 03/04/2024.
//

import Foundation

struct StatusResponse: Decodable {
    let success: Bool
    let statusCode: Int
    let statusMessage: String
}
