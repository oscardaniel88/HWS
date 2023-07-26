//
//  AddBookView.swift
//  Bookworm
//
//  Created by Daniel Camarena on 7/24/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Select genre"
    @State private var review = ""
    @State private var rating  = 3
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller", "Select genre"]
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    Picker("Genre", selection: $genre){
                        ForEach(genres, id:\.self){
                            Text($0)
                        }
                    }
                }
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.genre = genre
                        newBook.review = review
                        newBook.rating = Int16(rating)
                        newBook.date = Date.now
                        try? moc.save()
                        dismiss()
                    }.disabled(saveDisabled())
                }
            }
            .navigationTitle("Add Book")
        }
    }
    func saveDisabled() -> Bool {
        return
            title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            genre.elementsEqual("Select genre")
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
