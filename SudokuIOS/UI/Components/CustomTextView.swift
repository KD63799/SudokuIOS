//
//  CustomTextView.swift
//  SudokuIOS
//
//  Created by Amir on 28/10/2025.
//

import SwiftUI

struct CustomTextField: View {
    
    var title: String
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .foregroundStyle(.black)
                .fontWeight(.heavy)
                .font(.summaryNotes(size: 30))
            
            if isSecure {
                SecureField(
                    "",
                    text: $text,
                    prompt: Text(placeholder)
                        .foregroundColor(.gray.opacity(0.8))
                        .font(.summaryNotes(size: 20))
                )
                .padding(16)
                .background(Color.white)
                .cornerRadius(8)
                .disableAutocorrection(true)
            } else {
                TextField(
                    "",
                    text: $text,
                    prompt: Text(placeholder)
                        .foregroundColor(.gray.opacity(0.8))
                        .font(.summaryNotes(size: 20))
                )
                .padding(16)
                .background(Color.white)
                .cornerRadius(8)
                .disableAutocorrection(true)
            }
        }
    }
}

