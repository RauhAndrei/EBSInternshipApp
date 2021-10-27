//
//  HTPPURLResponse+Extensions.swift
//  EBSInternshipApp
//
//  Created by Rauh Andrei on 21.10.2021.
//

import Foundation

extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}
