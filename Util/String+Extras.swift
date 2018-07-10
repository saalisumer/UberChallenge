//
//  String+Extras.swift
//  UberChallenge
//
//  Created by Saalis Umer on 7/7/18.
//  Copyright © 2018 Saalis Umer. All rights reserved.
//

import Foundation
extension String {
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9 ]", options: .regularExpression) == nil
    }
}
