import Observation
import NetworkClient

@Observable
class SignInViewModel {
    
    var email: String = ""
    var password: String = ""
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let repository = SudokuRepository()
    
    func signIn(onSuccess: @escaping () -> Void) async {
        isLoading = true
        errorMessage = nil
        
        let response = await repository.signIn(email: email, password: password)
        
        isLoading = false
        
        if response.isSuccess, let authData = response.object {
            print("Connecté : \(authData.user.email)")
            print("\(authData.session.accessToken)")
            TokenManager.shared.saveTokens(
                accessToken: authData.session.accessToken,
                refreshToken: authData.session.refreshToken
            )
            onSuccess()
        } else {
            errorMessage = "Email ou mot de passe incorrect"
        }
    }
}
