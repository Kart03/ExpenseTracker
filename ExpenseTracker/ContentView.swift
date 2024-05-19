//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Kartikay Singh on 18/05/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var vm = LogListVM()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
//        #if os(macOS)
//        splitView
//        #elseif os(visionOS)
//        tabview
//        #else
//        switch horizontalSizeClass {
//            case .compact: tabview
//            default: splitView
//        }
//        #endif
        
        NavigationStack {
            LogListContainerV(vm: $vm)
        }
    }
    
    
    
    var tabview: some View {
        TabView {
            NavigationStack {
                LogListContainerV(vm: $vm)
            }
            .tabItem {
                Label("Expenses", systemImage: "tray")
            }
        }
    }
    
    var splitView: some View {
        Text("Split View")
    }
}

#Preview {
    ContentView()
}
