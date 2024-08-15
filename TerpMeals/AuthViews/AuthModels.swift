//
//  AuthModels.swift
//  TerpMeals
//
//  Created by krisnajit Rajeshkhanna on 6/23/24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    let id: String
    let email: String
    let first_name: String
    let last_name: String
    var full_name: String {
        return first_name + " " + last_name
    }
    let DOB: String
    let gender: String
    let weight: String
    let height_ft: String
    let height_in: String
    let din_hall_pref: String
    let cuisine_pref: String
}

class UserData: ObservableObject {
    @Published var preferredDiningHall: String?
    @Published var dietaryRestrictions: [String: Bool] = [
            "Dairy": false, "Nuts": false, "Eggs": false, "Sesame": false,
            "Soy": false, "Fish": false, "Gluten": false, "Shellfish": false,
            "Vegetarian": false, "Vegan": false, "Halal": false, "None": false
        ]
    @Published var gender: String?
    @Published var birthday: Date?
    @Published var age: Int?
    @Published var height: Double?
    @Published var heightMeasurement: String?
    @Published var weight: Double?
    @Published var weightMeasurement: String?
    @Published var goal: String?
    @Published var activityLevel: Double?
    // Add other properties as needed
}

enum Field: Hashable {
    case email
    case password
    case confirm_password
    case name
}

@MainActor
class AuthenticationModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func login(email:String, password:String) async throws {
        do {
            let res = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = res.user
            //await fetchData()
        } catch {
            print("AUTH: Failed to login existing user \"\(error.localizedDescription)\"")
        }
    }

    func signUp(email:String, password:String) async throws {
        do {
            let res = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = res.user
        } catch {
            print("AUTH: Failed to create new user with error \"\(error.localizedDescription)\"")
        }
    }
    
    func createUser(user: User) async throws{
        let encodedUser = try Firestore.Encoder().encode(user)
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
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currUser = nil
        } catch {
            print("AUTH: Failed to sign out current user \"\(error.localizedDescription)\"")
        }
    }
    
    func deleteAccount() {
        
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
    
    func saveUserInfo(userData: UserData, completion: @escaping (Error?) -> Void){
        let db = Firestore.firestore()
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"]))
            return
        }
        
        let data: [String: Any] = [
            "preferredDiningHall": userData.preferredDiningHall!,
            "dietaryRestrictions": userData.dietaryRestrictions,
            "gender": userData.gender!,
            "birthday": userData.birthday!,
            "age": userData.age!,
            "height": userData.height!,
            "heightMeasurement": userData.heightMeasurement!,
            "weight": userData.weight!,
            "weightMeasurement": userData.weightMeasurement!,
            "goal": userData.goal!,
            "activityLevel": userData.activityLevel!
        ]
        
        db.collection("users").document(userId).setData(data) { error in
            completion(error)
        }
    }
}
