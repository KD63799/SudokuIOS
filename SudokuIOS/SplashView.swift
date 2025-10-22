//
//  SplashView.swift
//  SudokuIOS
//
//  Created by Amir on 16/10/2025.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        SplashScreen()
    }
}

private extension SplashView {
    func SplashScreen() -> some View {
        VStack(spacing: 0) {
            ZStack {
                Image(.background)
                    .resizable()
                    .scaledToFill()
                
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 140)
                    
                    Image(.sudokuLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 280, height: 280)
                    
                    Spacer()
                        .frame(height: 40)
                    
                    VStack(spacing: 0) {
                        Text("Sudoku")
                            .font(.summaryNotes(size: 90))
                            .fontWeight(.black)
                            .foregroundStyle(.black)
                        
                        Text("Hatchling")
                            .font(.summaryNotes(size: 40))
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                    }
                    
                    Spacer()
                        .frame(minHeight: 100)
                }
            }
            
            VStack {
                Spacer()
                    .frame(height: 40)
                
                HStack(spacing: 20) {
                    Image(.loaderEggs)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 50)
                }
                
                Spacer()
                    .frame(height: 60)
            }
            .frame(maxWidth: .infinity)
            .background(Color.white)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
