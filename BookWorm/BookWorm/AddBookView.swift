//
//  AddBook.swift
//  BookWorm
//
//  Created by Daan Schutte on 19/11/2022.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 0
    @State private var genre = "Select genre"
    @State private var review = ""
    
    let genres = ["Select genre", "Fantasy", "Horror", "Kids", "Mystery", "Thriller", "Romance", "Poetry"]
    
    var invalidForm: Bool {
        return title.isEmpty || author.isEmpty || rating == 0 || genre == "Select genre" || review.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Book title", text: $title)
                    TextField("Book author", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
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
                        
                        try? moc.save()
                        
                        dismiss()
                    }
                    .disabled(invalidForm)
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
