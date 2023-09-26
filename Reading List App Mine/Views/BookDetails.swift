//
//  BookDetails.swift
//  Reading List App Mine
//
//  Created by Anisha Pareek on 7/24/23.
//

import SwiftUI

struct BookDetails: View {
    
    @EnvironmentObject var readingListModel: ReadingListModel
    @State var selectedGenre: Int = 0
    @State var selectedStatus: Int = 0
    @State var selectedRating: Int = 0
    var book: Book
    
    var body: some View {
        VStack {
            ScrollView {
                Text(book.title)
                    .font(.headline)
                    .onAppear {
                        selectedGenre = readingListModel.genres.firstIndex(of: book.genre) ?? 0
                        selectedStatus = readingListModel.statuses.firstIndex(of: book.status) ?? 0
                        selectedRating = book.rating
                    }
                Text(book.author)
                if book.pages != 0 {
                    Text("Pages: \(book.pages)")
                }
                Divider()
                
                // Stack with all the pickers
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
                    
                    Divider()
                    
                    Text("Status:")
                    Picker(selection: $selectedStatus) {
                        ForEach(0..<readingListModel.statuses.count) {
                            Text(readingListModel.statuses[$0])
                        }
                    } label: {
                        Text("")
                    }
                    .pickerStyle(.segmented)

                    Divider()
                    
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
                    let updatedBook = Book(id: book.id, title: book.title, author: book.author, genre: readingListModel.genres[selectedGenre], status: readingListModel.statuses[selectedStatus], pages: book.pages, rating: selectedRating)
                    readingListModel.updateBookData(book: updatedBook)
                } label: {
                    Text("Save Changes")
                        .padding(10)
                        .font(.headline)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(5)
                }
                Button("Delete Book", role: .destructive) {
                    readingListModel.deleteBook(book: book)
                }
                .padding(.top, 20)


            }
        }
    }
}

