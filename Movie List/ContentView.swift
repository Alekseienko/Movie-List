//
//  ContentView.swift
//  Movie List
//
//  Created by alekseienko on 01.09.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var title: String = ""
    @State var year: String = ""
    @State private var movie: Movie = Movie()
    @FocusState private var isFocused: Bool
    @State private var showAlert = false
    var body: some View {
        
        NavigationView {
            VStack {
                VStack{
                    TextField("Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.default)
                        .focused($isFocused)
                    TextField("Year", text: $year)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                    Button {
                        if movie.scanList(name: title) {
                            showAlert = true
                            isFocused = false
                            title = ""
                            year = ""
                        } else if !title.isEmpty && !year.isEmpty {
                            movie.addMovie(name: title, year: Int(year)!)
                            isFocused = false
                            title = ""
                            year = ""
                        }
                    } label: {
                        Text("Add")
                            .font(.title)
                    }
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(3)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Oops"),
                            message: Text("This film is already in your list")
                        )
                    }
                }
                .padding()
                List{
                    ForEach(movie.sortMovies()) { mov in
                        FilmRowList(name: mov.name, year: String(mov.year))
                    }
                    .onDelete { indexSet in
                        movie.movies.remove(atOffsets: indexSet)
                    }
                }
                .listStyle(InsetListStyle())
                Spacer()
            }
            .navigationTitle("My Film List")
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}

struct FilmRowList: View {
    var name: String
    var year: String
    var body: some View {
        HStack{
            Text("\(name)  \(year)")
                .bold()
                .padding()
            Spacer()
        }
    }
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        FilmRowList(name: "Forest gamp", year: "1994")
    }
}
