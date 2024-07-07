//
//  AuthModels.swift
//  TerpMeals
//
//  Created by krisnajit Rajeshkhanna on 6/23/24.
//

import Foundation
import Firebase

struct UserInfo: Identifiable, Codable {
    var id: String
    var email: String
    var first_name: String
    var last_name: String
    var age: Int
    var DOB: Int
    var gender: String
    var weight: Int
    var height_ft: Int
    var height_in: Int
    var din_hall_pref: String
    var cuisine_pref: String
}

enum Field: Hashable {
    case email
    case password
    case confirm_password
}

func login(email:String, password:String) {
    Auth.auth()
        .signIn(
            withEmail: email,
            password: password
        ) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
    }
}

func signup(email:String, password:String) {
    Auth.auth()
        .createUser(
            withEmail: email,
            password: password
        ) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
    }
}

func signOutAndDeleteUser(completion: @escaping (Error?) -> Void) {
    guard let user = Auth.auth().currentUser else {
        completion(nil)
        return
    }
    
    user.delete { error in
        if let error = error {
            completion(error)
            return
        }
        
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let signOutError as NSError {
            completion(signOutError)
        }
    }
}

/*func saveUserInfo(userId: String, firstName: String, lastName: String, age: Int, gender: String, completion: @escaping (Error?) -> Void) {
    let db = Firestore.firestore()
    db.collection("users").document(userId).setData([
        "firstName": firstName,
        "lastName": lastName,
        "age": age,
        "gender": gender
    ]) { error in
        completion(error)
    }
}*/
