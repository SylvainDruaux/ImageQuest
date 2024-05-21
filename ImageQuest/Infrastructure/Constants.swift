//
//  Constants.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 03/04/2024.
//

import Foundation

enum Constants {
    private static var config: [String: String]? = {
        guard let url = Bundle.main.url(forResource: "Config", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let config = try? JSONDecoder().decode([String: String].self, from: data) else {
            print("Warning: Config.json not found or unable to parse")
            return nil
        }
        return config
    }()
    
    private static func getValue(forKey key: String) -> String {
        guard let value = config?[key] else {
            fatalError("Missing \(key) in Config.json")
        }
        return value
    }
    
    static let clientId = getValue(forKey: "client_id")
    static let unsplashBaseURL = "https://api.unsplash.com/"
}
