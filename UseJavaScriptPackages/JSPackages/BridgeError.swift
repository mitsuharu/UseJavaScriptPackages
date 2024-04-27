//
//  BridgeError.swift
//  UseJavaScriptPackages
//
//  Created by Mitsuharu Emoto on 2024/04/27.
//

import Foundation

enum JavaScriptBridgeError: Error {
    case bundleNotFound
    case moduleFailed
    case bridgeFailed
    case functionFailed
    case argumentFailed
    case convertFailed
}
