//
//  Book.swift
//  Reading List App Mine
//
//  Created by Anisha Pareek on 7/23/23.
//

import Foundation

struct Book: Hashable, Identifiable {
    // ID is the document ID in the firestore database
    var id: String
    var title: String
    var author: String
    var genre: String
    var status: String
    var pages: Int
    var rating: Int
}
