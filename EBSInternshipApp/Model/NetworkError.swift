//
//  NetworkError.swift
//  EBSInternshipApp
//
//  Created by Rauh Andrei on 20.10.2021.
//

import Foundation

enum NetworkError: Error {
    case url
    case network
    case decoding
}

extension NetworkError {
    var errorDescription: String? {
        switch self {
        case .url:
            return "An error occurred while checking URL"
        case .network:
            return "An error occurred while fetching data"
        case .decoding:
            return "An error occurred while decoding data"
        }
    }
}
