//
//  GoogleAuth.swift
//  TerpMeals
//
//  Created by Krisnajit S Rajeshkhanna on 7/4/24.
//

import Firebase
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

struct GoogleLoginResultModel {
    let idToken: String
    let accessToken: String
}

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoURL: String?
    
    init(user: FirebaseAuth.User) {
        self.uid = user.uid
        self.email = user.email
        self.photoURL = user.photoURL?.absoluteString
    }
}

@MainActor
final class LoginModel: ObservableObject{
    
    func signInGoogle() async throws {
        
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accessToken: String = gidSignInResult.user.accessToken.tokenString
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
}

//final class AuthenticationManager {
//    
//    static let shared = AuthenticationManager()
//    private init() { }
//    
//    func getAuthenticatedUser() throws -> AuthDataResultModel {
//        guard let user = Auth.auth().currentUser else {
//            throw URLError(.badServerResponse)
//        }
//        
//        return AuthDataResultModel(user: user)
//    }
//    
//    func signOut() throws {
//        try Auth.auth().signOut()
//    }
//    
//}

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() { }
    
    @discardableResult
    func signInWithGoogle(tokens : GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
}
