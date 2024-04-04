//
//  Error+Connection.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 02/04/2024.
//

import Foundation

extension Error {
    /// A collection of error codes that are related to network connection failures.
    var NSURLErrorConnectionFailureCodes: [Int] {
        [
            NSURLErrorBackgroundSessionInUseByAnotherProcess, /// Error Code: `-996`
            NSURLErrorCannotFindHost, /// Error Code: ` -1003`
            NSURLErrorCannotConnectToHost, /// Error Code: ` -1004`
            NSURLErrorNetworkConnectionLost, /// Error Code: ` -1005`
            NSURLErrorNotConnectedToInternet, /// Error Code: ` -1009`
            NSURLErrorSecureConnectionFailed, /// Error Code: ` -1200`
        ]
    }
    
    /// Indicates an error that is caused by various connection-related issues or an unaccepted status code.
    /// See: `NSURLErrorConnectionFailureCodes`
    var isOtherConnectionError: Bool {
        NSURLErrorConnectionFailureCodes.contains(_code)
    }
}
