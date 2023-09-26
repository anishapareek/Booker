//
//  AddBook.swift
//  Reading List App Mine
//
//  Created by Anisha Pareek on 7/23/23.
//

import SwiftUI
import Combine

struct AddBook: View {
    
    @EnvironmentObject var readingListModel: ReadingListModel
    @State var bookTitle: String = ""
    @State var bookAuthor: String = ""
    @State var bookPages: String = ""
    @State var selectedGenre: Int = 0
    @State var selectedStatus: Int = 0
    @State var selectedRating: Int = 0
    
    var body: some View {
        VStack {
            Spacer()
            ScrollView {
                TextField("Book Title", text: $bookTitle)
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                
                TextField("Book Author(s)", text: $bookAuthor)
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                
                TextField("Number of Pages", text: $bookPages)
                    .keyboardType(.numberPad)
                    .onReceive(Just(bookPages)) { newValue in
                        let filtered = newValue.filter {
                            "0123456789".contains($0)
                        }
                        if filtered != newValue {
                            self.bookPages = filtered
                        }
                    }
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                
                // Stack with all the pickers for rating, status and genre
                VStack {
                    Text("Rating:")
                    Picker(selection: $selectedRating) {
                        ForEach(0..<6) { rating in
                            if rating == 0 {
                                Text("N/A")
                            } else {
                                Text("\(rating)")
                            }
                        }
                    } label: {
                        Text("")
                    }
                    .pickerStyle(.segmented)
                    
                    Text("Status:")
                    Picker(selection: $selectedStatus) {
                        ForEach(0..<readingListModel.statuses.count) {
                            Text("\(readingListModel.statuses[$0])")
                        }
                    } label: {
                        Text("")
                    }
                    .pickerStyle(.segmented)

                    Text("Genre:")
                    Picker(selection: $selectedGenre) {
                        ForEach(0..<readingListModel.genres.count) {
                            Text(readingListModel.genres[$0])
                        }
                    } label: {
                        Text("")
                    }
                    .pickerStyle(.wheel)

                }
                
                Button {
                    // Check if the title or author is blank
                    if bookTitle != "" && bookAuthor != "" {
                        let newBook = Book(id: "", title: bookTitle, author: bookAuthor, genre: readingListModel.genres[selectedGenre], status: readingListModel.statuses[selectedStatus], pages: Int(bookPages) ?? 0, rating: selectedRating)
                        readingListModel.addBook(book: newBook)
                        bookTitle = ""
                        bookAuthor = ""
                        bookPages = ""
                        selectedGenre = 0
                        selectedRating = 0
                        selectedStatus = 0
                    }
                } label: {
                    Text("Submit Book")
                }

            }
        }
    }
}

