//
//  Model.swift
//  Movie List
//
//  Created by alekseienko on 01.09.2022.
//

import Foundation

struct Film: Identifiable, Hashable {
    var id = UUID()
    var name: String = ""
    var year: Int = 0
}

struct Movie {
    var movies: Set<Film> = []
    // Add new film in list
    mutating func addMovie(name: String, year: Int) {
        let filter = movies.filter { $0.name.contains(name) }
        if filter.isEmpty {
            movies.insert(Film(name: name.capitalized, year: year))
        }
    }
    // Checks if the movie is in the list
    func scanList(name: String) -> Bool {
       let filter = movies.filter { $0.name.contains(name) }
       return !filter.isEmpty
   }
    
    func sortMovies() -> [Film] {
        return movies.sorted { $0.name < $1.name }
    }
    
}
