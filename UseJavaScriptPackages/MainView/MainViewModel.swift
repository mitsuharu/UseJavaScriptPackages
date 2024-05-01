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
    
    func receiptLine() {
        // command 作成（画像があると失敗する）
        do {
            guard
                let path = Bundle.main.path(forResource: "receipt-noimage", ofType: "txt"),
                let text = try? String(contentsOfFile: path)
            else {
                return
            }
                        
            let command = try bridge.runTransformCommand(text)
            
            print("=== command ===")
            print(command)
        } catch {
            print(error)
        }
        
        // svg 作成
        do {
            guard
                let path = Bundle.main.path(forResource: "receipt", ofType: "txt"),
                let text = try? String(contentsOfFile: path)
            else {
                return
            }
            let svg = try bridge.runTransformSvg(text)
                        
            print("=== svg ===")
            print(svg)
        } catch {
            print(error)
        }
    }
    
    init() {
//        receiptLine()
    }
    
}
