//
//  JustMean.swift
//  UseJavaScriptPackages
//
//  Created by Mitsuharu Emoto on 2024/04/21.
//

import Foundation
import JavaScriptCore

/**
 JavaScript の npm ライブラリを Swift から実行する
 */
final class JavaScriptBridge {
    
    private let context: JSContext = JSContext(virtualMachine: JSVirtualMachine())
    private var bridge: JSValue? = nil
    
    private let bundleFileName = "Module.bundle.js"
    private let moduleName = "Module"
    private let bundleName = "Bridge"
    
    init(){
        do {
            try setUp()
        }  catch {
            print(error)
        }
    }
    
    private func setUp() throws {
        // バンドルされた js ファイルを取得する
        guard
            let path = Bundle.main.path(forResource: bundleFileName, ofType: nil),
            let contents = try? String(contentsOfFile: path)
        else {
            throw JavaScriptBridgeError.bundleNotFound
        }
        
        // エラーハンドリング
        context.exceptionHandler = { context, error in
            guard let error = error,
                  let message = error.toString() else {
                return
            }
            print("JSContext#exceptionHandler Error: \(message)")
        }
        
        // Can't find variable: process の対応
        let processPolyfill = """
        var process = {
            env: {},
            nextTick: function(fn) { setTimeout(fn, 0) }
        };
        """
        context.evaluateScript(processPolyfill)

        // バンドルされた js ファイルの読み込み
        context.evaluateScript(contents)
        
        // ブリッヂを取得する
        guard
            let module = context.objectForKeyedSubscript(moduleName),
            let bridge = module.objectForKeyedSubscript(bundleName)
        else {
            throw JavaScriptBridgeError.bridgeFailed
        }
        self.bridge = bridge
    }
    
    private func getFunction(name: String) -> JSValue? {
        guard
            let bridge = bridge,
            let function = bridge.objectForKeyedSubscript(name)
        else {
            return nil
        }
        return function
    }
    
    func runMean(_ arg: [Double]) throws -> Double {
        guard let function = getFunction(name: "mean") else {
            throw JavaScriptBridgeError.functionFailed
        }
        guard let result =  function.call(withArguments: [arg]) else {
            throw JavaScriptBridgeError.argumentFailed
        }
        return result.toDouble()
    }
    
    func runRandom(_ arg: [Double]) throws -> Double {
        guard let function = getFunction(name: "random") else {
            throw JavaScriptBridgeError.functionFailed
        }
        guard let result =  function.call(withArguments: [arg]) else {
            throw JavaScriptBridgeError.argumentFailed
        }
        return result.toDouble()
    }
    
    func runTransformCommand(_ arg: String) throws -> Any {
        guard let function = getFunction(name: "transformCommand") else {
            throw JavaScriptBridgeError.functionFailed
        }
        guard let result =  function.call(withArguments: [arg]) else {
            throw JavaScriptBridgeError.argumentFailed
        }
        return result
    }
    
    func runTransformSvg(_ arg: String) throws -> Any {
        guard let function = getFunction(name: "transformSvg") else {
            throw JavaScriptBridgeError.functionFailed
        }
        guard let result =  function.call(withArguments: [arg]) else {
            throw JavaScriptBridgeError.argumentFailed
        }
        return result
    }
}


