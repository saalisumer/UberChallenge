//
//  NSError+Extras.swift
//  UberChallenge
//
//  Created by Saalis Umer on 7/7/18.
//  Copyright © 2018 Saalis Umer. All rights reserved.
//

import Foundation
let DEFAULT_ERROR_MESSAGE = "ERROR"
let KEYWORD_ERROR = "KEYWORD_ERROR"
let JSON_ERROR = "JSON_ERROR"


let MESSAGE_KEYWORD = "NSLocalizedDescription"
enum ERROR_CODE:Int
{
    case ERROR_CODE_INVALID_KEYWORD
    case ERROR_CODE_KEYWORD_LENGTH_TOO_SMALL
    case ERROR_CODE_KEYWORD_LENGTH_TOO_LARGE
    case ERROR_CODE_JSON_SERIALIZATION
}

extension NSError
{
    static func invalidKeywordError()->NSError
    {
        return NSError(domain: KEYWORD_ERROR, code: ERROR_CODE.ERROR_CODE_INVALID_KEYWORD.rawValue, userInfo: [MESSAGE_KEYWORD:"Keyword is invalid"])
    }
    
    static func keywordLengthLessThanThreeError()->NSError
    {
        return NSError(domain: KEYWORD_ERROR, code: ERROR_CODE.ERROR_CODE_KEYWORD_LENGTH_TOO_SMALL.rawValue, userInfo: [MESSAGE_KEYWORD:"Keyword Length Should Be Greater Than 3"])
    }
    
    static func keywordLengthGreaterThanFifteen()->NSError
    {
        return NSError(domain: KEYWORD_ERROR, code: ERROR_CODE.ERROR_CODE_KEYWORD_LENGTH_TOO_LARGE.rawValue, userInfo: [MESSAGE_KEYWORD:"Keyword Length Should Be Less Than Equal To 15"])
    }
    
    static func jsonSerializationError()->NSError
    {
        return NSError(domain: JSON_ERROR, code: ERROR_CODE.ERROR_CODE_JSON_SERIALIZATION.rawValue, userInfo: [MESSAGE_KEYWORD:"Couldn't read data"])
    }
}
