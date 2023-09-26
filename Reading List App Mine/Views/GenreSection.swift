//
//  GenreSection.swift
//  Reading List App Mine
//
//  Created by Anisha Pareek on 7/23/23.
//

import SwiftUI

struct GenreSection: View {
    @EnvironmentObject var readingListModel: ReadingListModel
    var genre: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(genre)
                .font(.title2)
                .onAppear {
                    readingListModel.getBooksByGenre(genre: genre)
                }
            if let books = readingListModel.books[genre] {
                ForEach(books) { book in
                    NavigationLink(destination: BookDetails(book: book)) {
                        VStack {
                            Text(book.title)
                                .font(.headline)
                                .padding(5)
                                .padding(.leading, 10)
                            Text(book.author)
                                .padding(.leading, 20)
                        }
                    }
                }
            }
        }
    }
}

