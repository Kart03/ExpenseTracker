//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Kartikay Singh on 18/05/24.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    #if os(macOS)
    @NSApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    #else
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    #endif
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            #if os(macOS)
                .frame(minWidth: 729, minHeight: 480)
            #endif
        }
        #if os(macOS)
        .windowResizability(.contentMinSize)
        #endif
    }
}
