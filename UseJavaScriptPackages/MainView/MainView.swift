//
//  MainView.swift
//  UseJavaScriptPackages
//
//  Created by Mitsuharu Emoto on 2024/04/27.
//

import SwiftUI

struct MainView: View {
    
    let viewModel = MainViewModel()
    
    var body: some View {
        Button("run mean") {
            viewModel.mean([1, 2, 3, 4, 5])
        }
        if let value = viewModel.meanValue {
            Text("meanValue of [1, 2, 3, 4, 5] is \(value)")
        } else {
            Text("meanValue of [1, 2, 3, 4, 5]  is none")
        }
        
        Spacer().frame(height: 30)
        
        Button("run random") {
            viewModel.random([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        }
        if let value = viewModel.randomValue {
            Text("randomValue of 0-9 is \(value)")
        } else {
            Text("randomValue of 0-9 is none")
        }
     
    }
}

#Preview {
    MainView()
}
