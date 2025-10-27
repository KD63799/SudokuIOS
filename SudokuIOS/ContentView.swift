//
//  ContentView.swift
//  SudokuIOS
//
//  Created by Amir on 20/10/2025.
//


import SwiftUI

struct ContentView: View {
    @State private var appState: AppState = .splash
    
    var body: some View {
        switch appState {
        case .splash:
            SplashView()
                .task {
                    try? await Task.sleep(for: .seconds(2))
                    appState = .unauthenticated
                }
        case .authenticated:
            SignInView(appState: $appState)
        case .unauthenticated:
            SignInView(appState: $appState)
        }
    }
}

enum AppState {
    case authenticated
    case unauthenticated
    case splash
}

#Preview {
    ContentView()
}
