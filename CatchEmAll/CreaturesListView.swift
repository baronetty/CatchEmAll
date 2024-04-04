//
//  CreaturesListView.swift
//  CatchEmAll
//
//  Created by Leo  on 02.04.24.
//

import SwiftUI

struct CreaturesListView: View {
    @StateObject var creaturesVM = CreaturesViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(0..<creaturesVM.creaturesArray.count, id: \.self) { index in
                    
                    LazyVStack {
                        NavigationLink {
                            DetailView(creature: creaturesVM.creaturesArray[index])
                        } label: {
                            Text("\(index + 1). \(creaturesVM.creaturesArray[index].name.capitalized)")
                                .font(.title2)
                        }
                    }
                    .onAppear {
                        if let lastCreature = creaturesVM.creaturesArray.last {
                            if creaturesVM.creaturesArray[index].name == lastCreature.name && creaturesVM.urlString.hasPrefix("http") {
                                Task {
                                    await creaturesVM.getData()
                                }
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Pokemon")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            Task {
                                await creaturesVM.loadAll()
                            }
                        } label: {
                            Text("Load all")
                        }
                    }
                    
                    ToolbarItem(placement: .status) {
                        Text("\(creaturesVM.creaturesArray.count) of \(creaturesVM.count)")
                    }
                }
                
                if creaturesVM.isLoading {
                    ProgressView()
                        .tint(.red)
                        .scaleEffect(2)
                }
            }
        }
        .task {
            await creaturesVM.getData()
        }
    }
}

#Preview {
    CreaturesListView()
}
