//
//  ContentView.swift
//  Reading List App Mine
//
//  Created by Anisha Pareek on 7/21/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FullView()
                .tabItem {
                    Image(systemName: "book")
                    Text("All Books")
                }
            GenreView()
                .tabItem {
                    Image(systemName: "folder")
                    Text("Genre")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
