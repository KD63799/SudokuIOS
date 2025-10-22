//
//  SplashView.swift
//  SudokuIOS
//
//  Created by Amir on 16/10/2025.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack {
            VStack(spacing: 38) {
                Image(.sudokuLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280, height: 280)
                
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
            }
            Spacer()
            Image(.loaderEggs)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 60)
        .padding(.bottom, 40)
        .background(alignment: .top) {
            Image(.background)
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    SplashView()
}
