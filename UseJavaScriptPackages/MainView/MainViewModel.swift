//
//  MainViewModel.swift
//  UseJavaScriptPackages
//
//  Created by Mitsuharu Emoto on 2024/04/27.
//

import Foundation
import Observation

@Observable
final class MainViewModel {
    @ObservationIgnored private let bridge = JavaScriptBridge()
    
    var meanValue: Double? = nil
    var randomValue: Double? = nil
    
    func mean(_ args: [Double]) {
        do {
            meanValue = try bridge.runMean(args)
        } catch {
            print(error)
        }
    }
    
    func random(_ args: [Double]) {
        do {
            randomValue = try bridge.runRandom(args)
        } catch {
            print(error)
        }
    }
    
}
