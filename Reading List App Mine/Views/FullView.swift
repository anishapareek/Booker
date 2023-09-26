//
//  FullView.swift
//  Reading List App Mine
//
//  Created by Anisha Pareek on 7/23/23.
//

import SwiftUI

struct FullView: View {
    @EnvironmentObject var readingListModel: ReadingListModel
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    AddBook()
                } label: {
                    Text("Add Book")
                }
                
                if readingListModel.genres.count == 0 {
                    Text("No genres/books found.")
                } else {
                    // Display each genre and all the books associated with each genre
                    List {
                        ForEach(readingListModel.genres, id: \.self) { genre in
                            GenreSection(genre: genre)
                        }
                    }
                }
            }

        }
    }
}

