//
//  JustMean.swift
//  UseJavaScriptPackages
//
//  Created by Mitsuharu Emoto on 2024/04/21.
//

import Foundation
import JavaScriptCore

/*
 NPM パッケージを Swift から呼び出す https://zenn.dev/platina/articles/1e4316e3f632b6
 */

final class Bridge {
    
    private let vm = JSVirtualMachine()
    
    private var context: JSContext!
    
    init(){
        setUp()
        runMean()
    }
    
    func setUp() {
        
        context = JSContext()
        
        // エラーハンドリング
        context.exceptionHandler = { c, e in
            print("JS Error: \(e!.toString()!)")
        }
        
        // バンドルされたJSファイルのロード
        if let jsSourcePath = Bundle.main.path(forResource: "Bridge.bundle", ofType: "js") {
            do {
                context = JSContext(virtualMachine: self.vm)
                
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                context.evaluateScript(jsSourceContents)
     
            } catch {
                print("Failed to load JavaScript file.")
            }
        }
    }
    
    func runMean() {
        
        let module = self.context.objectForKeyedSubscript("Bridge")
        let bridge = module?.objectForKeyedSubscript("Bridge")

        if let result = bridge?.objectForKeyedSubscript("mean").call(withArguments: [[1,2,3]]) {

            print("mean is \(result)")
        }
    }
    
}

