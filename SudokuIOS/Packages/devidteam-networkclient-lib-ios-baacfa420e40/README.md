# NetworkClient

Un package Swift léger et type-safe pour simplifier les appels réseau dans vos applications iOS.

## Prérequis

- iOS 17.0+
- Swift 6.2+
- Xcode 16.0+

## Installation

### Swift Package Manager

Ajoutez NetworkClient à votre projet via SPM :

1. Dans Xcode, allez dans **File > Add Package Dependencies...**
2. Entrez l'URL du repository ("git@bitbucket.org:devidteam/networkclient-lib-ios.git")
3. Sélectionnez la version désirée

## Utilisation

### Configuration de base

#### 1. Initialiser le NetworkClient

```swift
import NetworkClient

// Configuration avec paramètres par défaut
let client = try NetworkClient(baseUrl: "https://api.example.com")

// Configuration personnalisée
let customConfig = NetworkClientConfig(
    defaultRequestTimeout: 30.0,
    sessionHeaders: [
        "Accept": "application/json",
        "Content-Type": "application/json"
    ],
    jsonDecoder: JSONDecoder()
)

let client = try NetworkClient(
    baseUrl: "https://api.example.com",
    config: customConfig
)
```

#### 2. Définir vos endpoints

Créez des extensions pour organiser vos endpoints par domaine métier :

```swift
import NetworkClient

extension Endpoint {
    enum Products {
        static let getAll = Endpoint(
            urlString: Config.baseUrl + "/api/v1/products",
            method: .get,
            queryItems: [URLQueryItem(name: "select", value: "*")]
        )

        static func getById(_ id: String) -> Endpoint {
            Endpoint(
                urlString: Config.baseUrl + "/api/v1/products/\(id)",
                method: .get
            )
        }
    }

    enum Auth {
        static let signIn = Endpoint(
            urlString: Config.baseUrl + "/auth/sign-in",
            method: .post
        )

        static let refreshToken = Endpoint(
            urlString: Config.baseUrl + "/auth/refresh",
            method: .post
        )
    }
}
```

#### 3. Effectuer des requêtes

```swift
// Requête GET simple
let endpoint = Endpoint.Products.getAll
let response: NetworkClientResponse<[Product]> = await client.dataTask(
    url: endpoint.url,
    httpMethod: endpoint.method
)

// Requête POST avec body
let credentials = SignInBody(email: "user@example.com", password: "password")
let body = try JSONEncoder().encode(credentials)
let endpoint = Endpoint.Auth.signIn

let response: NetworkClientResponse<AuthResponse> = await client.dataTask(
    url: endpoint.url,
    httpMethod: endpoint.method,
    body: body
)

// Requête avec authentification
let response: NetworkClientResponse<User> = await client.dataTask(
    url: endpoint.url,
    httpMethod: endpoint.method,
    accessToken: "votre-access-token"
)
```

#### 4. Gérer les réponses

```swift
let response: NetworkClientResponse<[Product]> = await client.dataTask(
    url: endpoint.url,
    httpMethod: endpoint.method
)

// Vérifier le succès
if response.isSuccess {
    if let products = response.object {
        print("Produits récupérés : \(products.count)")
    }
}

// Vérifier le code de statut
if response.statusCode == 401 {
    print("Non autorisé - rafraîchir le token")
}

// Gérer les erreurs
if let error = response.error {
    switch error {
    case .decodingFailed(let data, let error):
        print("Échec du décodage : \(error)")
        print("Données brutes : \(data)")
    case .requestFailed(let error):
        print("Échec de la requête : \(error)")
    }
}
```

### Exemple d'implémentation complète

Voici un exemple complet d'un NetworkClientManager avec gestion automatique du refresh token :

```swift
import Foundation
import NetworkClient

class NetworkClientManager {
    private(set) var client: NetworkClient
    private let baseUrl: String

    init(baseUrl: String) {
        do {
            self.client = try .init(
                baseUrl: baseUrl,
                config: .init(
                    defaultRequestTimeout: 20.0,
                    sessionHeaders: [
                        "Accept": "application/json",
                        "Content-Type": "application/json"
                    ],
                    jsonDecoder: JSONDecoder.shared
                )
            )
            self.baseUrl = baseUrl
        } catch {
            fatalError("Impossible d'initialiser NetworkClient")
        }
    }

    func dataTask<T: Decodable>(
        customSession: URLSession? = nil,
        url: URL,
        httpMethod: HttpMethod,
        body: Data? = nil,
        authenticationScheme: String = "Bearer ",
        accessToken: String? = nil,
        refreshTokensAndRetry: Bool = true
    ) async -> NetworkClientResponse<T> {
        let initialRequest: NetworkClientResponse<T> = await client.dataTask(
            customSession: customSession,
            url: url,
            httpMethod: httpMethod,
            body: body,
            authenticationScheme: authenticationScheme,
            accessToken: accessToken
        )

        // Gestion automatique du refresh token en cas d'erreur 401
        if initialRequest.statusCode == 401, refreshTokensAndRetry {
            let refreshTokenResponse: NetworkClientResponse<RefreshTokenResponse> = await refreshTokens()

            if let newAccessToken = refreshTokenResponse.object?.session?.accessToken {
                // Réessayer la requête avec le nouveau token
                return await client.dataTask(
                    customSession: customSession,
                    url: url,
                    httpMethod: httpMethod,
                    body: body,
                    authenticationScheme: authenticationScheme,
                    accessToken: newAccessToken
                )
            }
        }

        return initialRequest
    }

    private func refreshTokens<T: Decodable>() async -> NetworkClientResponse<T> {
        let endpoint = Endpoint.Auth.refreshToken
        return await client.dataTask(
            url: endpoint.url,
            httpMethod: endpoint.method
        )
    }
}
```

### Exemple d'utilisation dans un Repository

```swift
import Foundation
import NetworkClient

class ApiProductsRepository: ProductsRepository {
    private let networkClientManager: NetworkClientManager

    init(networkClientManager: NetworkClientManager) {
        self.networkClientManager = networkClientManager
    }

    func fetchProducts() async throws -> [Product] {
        let endpoint = Endpoint.Products.getAll

        let response: NetworkClientResponse<[ProductDto]> = await networkClientManager.dataTask(
            url: endpoint.url,
            httpMethod: endpoint.method
        )

        if let error = response.error {
            print("Erreur réseau : \(error)")
        }

        if response.statusCode == 401 {
            throw ProductsRepositoryError.unauthorized
        }

        return response.object?.map { $0.toDomain() } ?? []
    }
}
```

## Types disponibles

### HttpMethod

Méthodes HTTP supportées :

```swift
public enum HttpMethod: String {
    case get, patch, put, post, delete, head, options, trace, connect
}
```

### NetworkClientResponse

Structure de réponse générique :

```swift
public struct NetworkClientResponse<T: Decodable> {
    public let object: T?              // L'objet décodé (si succès)
    public let statusCode: Int?        // Code de statut HTTP
    public let response: HTTPURLResponse?  // Réponse HTTP complète
    public let error: NetworkClientError?  // Erreur (si échec)

    public var isSuccess: Bool  // true si statusCode est entre 200-299
}
```

### NetworkClientError

Erreurs possibles :

```swift
public enum NetworkClientError {
    case decodingFailed(serializedData: String, error: Error)  // Échec du décodage JSON
    case requestFailed(Error)  // Échec de la requête réseau
}
```

### NetworkClientConfig

Configuration du client :

```swift
public class NetworkClientConfig {
    public let defaultRequestTimeout: TimeInterval  // Timeout par défaut (20s)
    public let sessionHeaders: [String: String]     // Headers communs à toutes les requêtes
    public let jsonDecoder: JSONDecoder            // Décodeur JSON personnalisé
}
```

## Tests et Mocks

NetworkClientResponse inclut un initializer pour les tests :

```swift
let mockResponse = NetworkClientResponse<Product>(
    mockData: Product(id: "1", name: "Test Product"),
    statusCode: 200
)
```

## Logging

En mode DEBUG, NetworkClient affiche automatiquement les logs de requêtes dans la console avec :
- URL et méthode HTTP
- Headers de la requête
- Corps de la requête (si présent)

## Bonnes pratiques

1. **Centralisation des endpoints** : Définissez tous vos endpoints dans des extensions `Endpoint` groupées par domaine métier
2. **Configuration partagée** : Créez un NetworkClientManager singleton ou injecté via DI
3. **Gestion des erreurs** : Vérifiez toujours `response.error` et `response.statusCode`
4. **Refresh token** : Implémentez la logique de refresh token dans un NetworkClientManager wrapper
5. **Type-safety** : Utilisez des types Decodable forts pour vos réponses API

## Auteur

Martin Gabillet

## Contribution

Les contributions sont les bienvenues ! N'hésitez pas à ouvrir une issue ou une pull request.
