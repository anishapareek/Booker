//
//  Reading_List_App.swift
//  Reading List App Mine
//
//  Created by Anisha Pareek on 7/21/23.
//

import SwiftUI
import Firebase

@main
struct Reading_List_App: App {
    
    init() {
        // Set up firebase for the app
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ReadingListModel())
                
        }
    }
}
