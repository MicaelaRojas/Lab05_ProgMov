//
//  PokeViewModel.swift
//  ProjectMVVM
//
//  Created by MAC17 on 23/04/22.
//

import Foundation

class PokeViewModel {
    
    let URL_API = "https://pokeapi.co/api/v2/pokemon?limit=500"
    
    var pokemons = [Result]()
    
    func getDataFromAPI() async {
    
        guard let url = URL(string: URL_API) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decoder = try? JSONDecoder().decode(Pokemon.self, from: data) {
                
                DispatchQueue.main.async(execute: {
                    decoder.results.forEach { pokemon in
                        
                        self.pokemons.append(pokemon)
                    }
                })
            }
        } catch {
            print("Invalid error")
        }
    }
    
}
