//
//  ContentView.swift
//  ProgressView
//
//  Created by Leo  on 04.04.24.
//

import SwiftUI

struct ContentView: View {
    @State private var showProgressView = false
    
    var body: some View {
        VStack {
            Spacer()
            
            if showProgressView {
                ProgressView()
                    .tint(.red)
                    .scaleEffect(4)
            }
            
            Spacer()
            
            Button("Toggle Progress View") {
                showProgressView.toggle()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
