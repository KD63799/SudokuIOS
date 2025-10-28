//
//  Token.swift
//  SudokuIOS
//
//  Created by Amir on 24/10/2025.
//

import SwiftUI

struct SignInView: View {
    
    @Bindable private var vm = SignInViewModel()
    @Binding var appState : AppState
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 100) {
                
                Text("Sign In")
                    .foregroundStyle(.black)
                    .fontWeight(.heavy)
                    .font(.summaryNotes(size: 50))
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    CustomTextField(
                        title: "Your email :",
                        placeholder: "Enter your email",
                        text: $vm.email
                    )
                    
                    CustomTextField(
                        title: "Your password :",
                        placeholder: "Enter your password",
                        text: $vm.password,
                        isSecure: true
                    )
                    
                    NavigationLink("No Account ? create one here.") {

                    }
                    .font(.summaryNotes(size: 20))
                    .underline()
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    Task {
                        await vm.signIn {
                            appState = .authenticated
                        }
                    }
                }) {
                    Text("Sign In")
                        .foregroundStyle(.white)
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
                .padding()
            }
            .padding(.top, 60)
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
    SignInView(appState: .constant(.splash))
}
