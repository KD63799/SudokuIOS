import SwiftUI

struct SignInView: View {
    
    @Bindable private var vm = SignInViewModel()
    @Binding var appState : AppState
    
    var body: some View {
        NavigationStack {
        VStack(alignment: .leading, spacing: 100) {
            
            Text("Sign In")
                .foregroundColor(.black)
                .fontWeight(.heavy)
                .font(.summaryNotes(size: 50))
                .padding(.horizontal)
            

            VStack(alignment: .leading, spacing: 16) {
                
                Text("Your email :")
                    .foregroundColor(.black)
                    .fontWeight(.heavy)
                    .font(.summaryNotes(size: 30))
                
                TextField(
                    "",
                    text: $vm.email,
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
                    text: $vm.password,
                    prompt: Text("Enter your password")
                        .foregroundColor(.gray.opacity(0.8))
                        .font(.summaryNotes(size: 20))
                )
                .padding(16)
                .background(Color.white)
                .cornerRadius(8)
                .disableAutocorrection(true)
                
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
