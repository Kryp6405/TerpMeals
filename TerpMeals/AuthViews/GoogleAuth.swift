//
//  GoogleAuth.swift
//  TerpMeals
//
//  Created by Krisnajit S Rajeshkhanna on 7/4/24.
//

import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

struct GoogleLoginResultModel {
    let idToken: String
    let accessToken: String
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
