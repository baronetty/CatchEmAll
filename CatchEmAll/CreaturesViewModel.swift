//
//  CreaturesViewModel.swift
//  CatchEmAll
//
//  Created by Leo  on 02.04.24.
//

import Foundation

@MainActor
class CreaturesViewModel: ObservableObject {
    
    private struct Returned: Codable { //  VERY IMPORTANT JSON values are Codable
        var count: Int
        var next: String?
        var results: [Creature]
    }
    
    @Published var urlString = "https://pokeapi.co/api/v2/pokemon/"
    @Published var count = 0
    @Published var creaturesArray: [Creature] = []
    @Published var isLoading = false
    
    func getData() async {
        print("🕸️ We are accessing the url \(urlString)")
        isLoading = true
        
        // convert urlString to a special URL type
        guard let url = URL(string: urlString) else {
            print("🤬 ERROR: Could not create a URL from \(urlString).")
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Try to decode JSON data into our own data structures
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("🤬 JSON ERROR: Could not decode returned JSON data.")
                isLoading = false
                return
            }
            self.count = returned.count
            self.urlString = returned.next ?? ""
            self.creaturesArray = self.creaturesArray + returned.results
            isLoading = false
        } catch {
            isLoading = false
            print("🤬 ERROR: Could not get data from \(urlString).")
        }
    }
    
    func loadAll() async {
        guard urlString.hasPrefix("http") else { return }
        
        await getData()
        await loadAll()
    }
}
