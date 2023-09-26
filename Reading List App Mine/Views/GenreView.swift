//
//  GenreView.swift
//  Reading List App Mine
//
//  Created by Anisha Pareek on 7/23/23.
//

import SwiftUI

struct GenreView: View {
    @EnvironmentObject var readingListModel: ReadingListModel
    @State var newGenre = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("New genre", text: $newGenre)
                    .multilineTextAlignment(.center)
                Button {
                    if newGenre != "" {
                        readingListModel.addGenre(genre: newGenre)
                        readingListModel.getGenres()
                        newGenre = ""
                    }
                } label: {
                    Text("Add genre")
                }
                Divider()
                // List of genres
                if readingListModel.genres.count == 0 {
                    Text("No genres found. Add a genre to get started.")
                } else {
                    ScrollView {
                        ForEach(readingListModel.genres, id: \.self) { genre in
                            NavigationLink {
                                List {
                                    GenreSection(genre: genre)
                                }
                            } label: {
                                Text(genre)
                            }

                        }
                    }
                }
                
                Spacer()

            }
        }
    }
}
