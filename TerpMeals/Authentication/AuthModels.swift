//
//  AuthModels.swift
//  TerpMeals
//
//  Created by krisnajit Rajeshkhanna on 6/23/24.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

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

func saveUserInfo(userId: String, firstName: String, lastName: String, birthdate: Date, gender: Int, weight: String, 
                  height_ft: String, height_in: String, preferredDiningHall: Int, preferredCuisine: String, isKg: Bool, completion: @escaping (Error?) -> Void) {
    let db = Firestore.firestore()
    
    // Define a mapping between gender values and labels
    let genderLabels = ["Male", "Female", "Other"]
    let genderLabel = gender < genderLabels.count ? genderLabels[gender] : "Other"
    
    let diningHallLabels = ["Select", "251 North", "The Yahentimitsi", "South Diner"]
    let diningHallLabel = diningHallLabels[preferredDiningHall]
    
    
    // Prepare data to be saved
    let data: [String: Any] = [
        "firstName": firstName,
        "lastName": lastName,
        "birthdate": Timestamp(date: birthdate),
        "gender": genderLabel,
        "weight": weight,
        "height_ft": height_ft,
        "height_in": height_in,
        "preferredDiningHall": diningHallLabel,
        "preferredCuisine": preferredCuisine,
        "isKg": isKg
    ]
    
    // Save data to Firestore
    db.collection("users").document(userId).setData(data) { error in
        completion(error)
    }
}
    
func checkUserExists(completion: @escaping (Bool, String?) -> Void) {
    if let currentUser = Auth.auth().currentUser {
        let uid = currentUser.uid
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)
        
        userRef.getDocument { document, error in
            if let document = document, document.exists {
                // Document exists, user exists in the database
                completion(true, uid)
            } else {
                // Document does not exist or there was an error
                if let error = error {
                    print("Error fetching document: \(error)")
                }
                completion(false, nil)
            }
        }
    } else {
        completion(false, nil)
    }
}

