//
//  AddBook.swift
//  Project-11-Bookworm
//
//  Created by Pawel Baranski on 23/01/2023.
//

import SwiftUI

struct AddBook: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.managedObjectContext) var moc
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    TextEditor(text: $review)

                    RaitingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }

                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        newBook.dateNow = Date.now

                        try? moc.save()
                        dismiss()
                    }.disabled(checkIfCanBeDisabled())
                }
            }
            .navigationTitle("Add Book")
        }
    }
    
    func checkIfCanBeDisabled() -> Bool {
        return title.isEmpty || author.isEmpty || genre.isEmpty
    }
}

struct AddBook_Previews: PreviewProvider {
    static var previews: some View {
        AddBook()
    }
}
