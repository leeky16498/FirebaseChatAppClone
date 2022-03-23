//
//  FirebaseChatAppCloneApp.swift
//  FirebaseChatAppClone
//
//  Created by Kyungyun Lee on 23/03/2022.
//

import SwiftUI
import Firebase

@main
struct FirebaseChatAppCloneApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
