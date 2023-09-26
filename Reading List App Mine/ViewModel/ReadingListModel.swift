//
//  ReadingListModel.swift
//  Reading List App Mine
//
//  Created by Anisha Pareek on 7/23/23.
//

import Foundation
import Firebase

class ReadingListModel: ObservableObject {
    @Published var genres: [String] = []
    @Published var books: [String: [Book]] = [:]
    @Published var statuses = ["Plan to read", "Reading", "On hold", "Completed"]
    
    init() {
        getGenres()
    }

    func addBook(book: Book) {
        let db = Firestore.firestore()
        db.collection("books").addDocument(data: [
            "title": book.title,
            "author": book.author,
            "genre": book.genre,
            "status": book.status,
            "pages": book.pages,
            "rating": book.rating
        ]) {error in
            if let error {
                print(error.localizedDescription)
                print("\n Unable to add book \(book.id)")
            }
        }
    }
    
    func deleteBook(book: Book) {
        let db = Firestore.firestore()
        let book = db.collection("books").document(book.id).delete() { error in
            if let error {
                print(error.localizedDescription)
                print("Could not delete the book \(book.id)")
            }
        }
    }
    
    // Update a book document's genre, status and rating fields
    func updateBookData(book: Book) {
        let db = Firestore.firestore()
        db.collection("books").document(book.id).updateData(["genre": book.genre,
                                                             "status": book.status,
                                                             "rating": book.rating]) {error in
            if let error {
                print(error.localizedDescription)
                print("\nCould not update the data for the book \(book.id)")
            }
        }
    }
    
    func getBooksByGenre(genre: String) {
        let db = Firestore.firestore()
        let query = db.collection("books").whereField("genre", isEqualTo: genre)
        query.getDocuments { querySnapshot, error in
            if let error {
                print(error.localizedDescription)
            } else if let querySnapshot {
                var allBooks: [Book] = []
                for doc in querySnapshot.documents {
                    let data = doc.data()
                    let id = doc.documentID
                    let title = data["title"] as? String ?? ""
                    let author = data["author"] as? String ?? ""
                    let genre = data["genre"] as? String ?? ""
                    let status = data["status"] as? String ?? ""
                    let pages = data["pages"] as? Int ?? 0
                    let rating = data["rating"] as? Int ?? 1
                    allBooks.append(Book(id: id, title: title, author: author, genre: genre, status: status, pages: pages, rating: rating))
                }
                self.books[genre] = allBooks
            } else {
                print("No data was returned.")
            }
        }
    }
    
    
    func addGenre(genre: String) {
        let db = Firestore.firestore()
        db.collection("genres").document(genre).setData([:])
    }
    
    // get all genres
    func getGenres() {
        let db = Firestore.firestore()
        db.collection("genres").getDocuments { querySnapshot, error in
            if let error {
                print(error.localizedDescription)
            } else if let querySnapshot {
                var allGenres: [String] = []
                for doc in querySnapshot.documents {
                    allGenres.append(doc.documentID)
                }
                self.genres = allGenres
            }
        }
    }
}
