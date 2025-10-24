import Foundation
import NetworkClient

private enum Config {
    static let baseUrl = "https://kzawzstixxfjivfulbmm.supabase.co"
    static let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt6YXd6c3RpeHhmaml2ZnVsYm1tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk4NjA0MjYsImV4cCI6MjA3NTQzNjQyNn0.yKD5zOG5YwCvRbEI8-mLLiYGdg5BPbmKk7rLVayCruQ"
}

enum ClientProvider {
    static let shared: NetworkClient = {
        do {
            let customConfig = NetworkClientConfig(
                defaultRequestTimeout: 30.0,
                sessionHeaders: [
                    "apikey": Config.apiKey,
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                ],
                jsonDecoder: JSONDecoder()
            )
            return try NetworkClient(baseUrl: Config.baseUrl, config: customConfig)
        } catch {
            fatalError("Failed to initialize NetworkClient: \(error)")
        }
    }()
}

extension Endpoint {
    enum Sudoku {
        static let updatePseudo = Endpoint(
            urlString: Config.baseUrl + "/functions/v1/update-pseudo",
            method: .post
        )

        static let getGridByLevel = Endpoint(
            urlString: Config.baseUrl + "/functions/v1/get-grid-by-level",
            method: .post
        )

        static let checkSolution = Endpoint(
            urlString: Config.baseUrl + "/functions/v1/check-solution",
            method: .post
        )
    }

    enum Auth {
        static let signIn = Endpoint(
            urlString: Config.baseUrl + "/functions/v1/sign-in",
            method: .post
        )

        static let signUp = Endpoint(
            urlString: Config.baseUrl + "/functions/v1/register",
            method: .post
        )
    }
}

class SudokuRepository {
    private let client = ClientProvider.shared
    
    func signIn(email: String, password: String) async -> NetworkClientResponse<AuthResponse> {
        let endpoint = Endpoint.Auth.signIn
        let body = SignInBody(email: email, password: password)
        
        guard let encodedBody = try? JSONEncoder().encode(body) else {
            return NetworkClientResponse(mockData: nil, statusCode: 400)
        }
        
        return await client.dataTask(
            url: endpoint.url,
            httpMethod: endpoint.method,
            body: encodedBody
        )
    }
    
    func signUp(email: String, password: String, pseudo: String?) async -> NetworkClientResponse<AuthResponse> {
        let endpoint = Endpoint.Auth.signUp
        let body = SignUpBody(email: email, password: password, pseudo: pseudo!)
        
        guard let encodedBody = try? JSONEncoder().encode(body) else {
            return NetworkClientResponse(mockData: nil, statusCode: 400)
        }
        
        return await client.dataTask(
            url: endpoint.url,
            httpMethod: endpoint.method,
            body: encodedBody
        )
    }
}
