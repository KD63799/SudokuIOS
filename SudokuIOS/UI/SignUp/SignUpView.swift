//
//  SignUpView.swift
//  SudokuIOS
//
//  Created by Amir on 22/10/2025.
//

import SwiftUI


struct SignUpView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Binding var appState : AppState

    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {
                
                Text("Sign Up")
                    .foregroundColor(.black)
                    .fontWeight(.heavy)
                    .font(.summaryNotes(size: 50))
                    .padding(.horizontal)
                
                Spacer()

                VStack(alignment: .leading, spacing: 16) {
                    
                    Text("Your email :")
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                        .font(.summaryNotes(size: 30))
                    
                    TextField(
                        "",
                        text: $email,
                        prompt: Text("Enter your email")
                            .foregroundColor(.gray.opacity(0.8))
                            .font(.summaryNotes(size: 20))
                    )
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(8)
                    .disableAutocorrection(true)

                    Text("Your password :")
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                        .font(.summaryNotes(size: 30))

                    SecureField(
                        "",
                        text: $password,
                        prompt: Text("Enter your password")
                            .foregroundColor(.gray.opacity(0.8))
                            .font(.summaryNotes(size: 20))
                    )
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(8)
                    .disableAutocorrection(true)
                    
                    Text("Confirm your password :")
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                        .font(.summaryNotes(size: 30))

                    SecureField(
                        "",
                        text: $confirmPassword,
                        prompt: Text("Enter your password confirmation")
                            .foregroundColor(.gray.opacity(0.8))
                            .font(.summaryNotes(size: 20))
                    )
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(8)
                    .disableAutocorrection(true)
                }
                .padding(.horizontal)
                
                Spacer()

                Button(action: {
                }) {
                    Text("Create account")
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .font(.summaryNotes(size: 40))
                        .frame(maxWidth: .infinity)
                }
                .background(
                    Image(.buttonPrimary)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                )
                .frame(height: 50)
                .padding(.horizontal)
                .padding()
            }
            .padding(.top, 30)
            .padding(.bottom, 10)
            .background(alignment: .top) {
                Image(.background)
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    SignUpView(appState: .constant(.splash))
}
