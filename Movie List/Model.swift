//
//  Model.swift
//  Movie List
//
//  Created by alekseienko on 01.09.2022.
//

import Foundation

struct Film: Identifiable {
    var id = UUID()
    var name: String = ""
    var year: Int = 0
}

struct Movie {
    
    var movies: [Film] = []
    // Add new film in list
    mutating func addMovie(name: String, year: Int) {
            movies.append(Film(name: name, year: year))
    }
    // Checks if the movie is in the list
    func scanList(name: String) -> Bool {
       let filter = movies.filter { $0.name.contains(name) }
       return !filter.isEmpty
   }
    
}
