//
//  UserForm.swift
//  TerpMeals
//
//  Created by Krisnajit S Rajeshkhanna on 7/5/24.
//

import UIKit
import SwiftUI
import Firebase

extension View {
    func hideKeyboard(){
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            picker.dismiss(animated: true)
        }
    }
}

struct UserForm: View {
    @State private var profileImage: UIImage?
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var birthdate = Date()
    @State private var gender = 0
    @State private var weight: String = ""
    @State private var height_ft: String = ""
    @State private var height_in: String = ""
    @State private var preferredDiningHall = 0
    @State private var preferredCuisine: String = ""
    @State private var showImagePicker: Bool = false
    @State private var isKg: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: geo.size.width, height: geo.size.height * 2 / 3)
                        .offset(y: geo.size.height * 1 / 3 + geo.safeAreaInsets.top)
                    
                    VStack {
                        headerSection
                        formSection
                            .padding(.horizontal, 20)
                    }
                    .padding(10)
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        signOutAndDeleteUser { error in
                            if let error = error {
                                print("Error signing out and deleting user: \(error)")
                                return
                            }
                            
                            DispatchQueue.main.async {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.red)
                    }
                    
                }
            
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        
                    }) {
                        Text("Save")
                            .foregroundColor(.red)
                    }
                }
                
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button(action: {
                        hideKeyboard()
                    }) {
                        Image(systemName: "keyboard.chevron.compact.down")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
    
    private var headerSection: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        Text("Let's Get Started!")
                            .font(.title2)
                            .fontWeight(.light)
                            .foregroundColor(.black.opacity(0.75))
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    HStack {
                        Text("Create Profile")
                            .font(.system(size: 45))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                }
                
                Button(action: {
                    self.showImagePicker = true
                }) {
                    if let profileImage = profileImage {
                        Image(uiImage: profileImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } else {
                        Circle()
                            .fill(Color.clear)
                            .frame(width: 100, height: 100)
                            .overlay(
                                Image("Profile")
                                    .resizable()
                                    .scaledToFit()
                                    .opacity(0.8)
                            )
                    }
                }
                .padding()
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(image: self.$profileImage)
                }
            }
        }
    }
    
    private var formSection: some View {
        VStack {
            Form {
                personalInformationSection
                extraDataSection
                preferencesSection
            }
            .tint(.red)
            .background(Color.gray.opacity(0.07))
            .scrollContentBackground(.hidden)
        }
        .background(Color.white)
        .cornerRadius(5)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
    }
    
    private var personalInformationSection: some View {
        Section(header: Text("Personal Information")) {
            TextField("First Name", text: $firstName)
            TextField("Last Name", text: $lastName)
            DatePicker("Birthdate", selection: $birthdate, displayedComponents: .date)
        }
    }
    
    private var extraDataSection: some View {
        Section(header: Text("Extra Data")) {
            Picker("Gender", selection: $gender) {
                Text("Male").tag(0)
                Text("Female").tag(1)
                Text("Other").tag(2)
            }.pickerStyle(.segmented)
            HStack {
                TextField("Feet", text: $height_ft)
                    .keyboardType(.decimalPad)
                Divider()
                TextField("Inches", text: $height_in)
                    .keyboardType(.decimalPad)
            }
            
            Toggle(isOn: $isKg) {
                HStack {
                    TextField("Weight", text: $weight)
                        .keyboardType(.decimalPad)
                    Text(isKg ? "kg" : "lbs")
                }
            }
            

        }
    }
    
    private var preferencesSection: some View {
        Section("Preferences") {
            Picker("Dining Hall", selection: $preferredDiningHall) {
                Text("Select").tag(0)
                Text("251 North").tag(1)
                Text("The Yahentimitsi").tag(2)
                Text("South Diner").tag(3)
            }
            TextField("Cuisine", text: $preferredCuisine)
        }
    }
}


struct UserForm_Previews: PreviewProvider {
    static var previews: some View {
        UserForm()
    }
}

#Preview {
    UserForm()
}

/*func saveUserInfo() {
        guard let profileImage = profileImage,
              let imageData = profileImage.jpegData(compressionQuality: 0.8) else {
            print("Missing profile image")
            return
        }
        
        let storageRef = Storage.storage().reference().child("profile_images/\(UUID().uuidString).jpg")
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("Failed to upload image: \(error)")
                return
            }
            
            storageRef.downloadURL { (url, error) in
                if let error = error {
                    print("Failed to retrieve download URL: \(error)")
                    return
                }
                
                guard let url = url else {
                    print("Download URL is nil")
                    return
                }
                
                let userData: [String: Any] = [
                    "firstName": self.firstName,
                    "lastName": self.lastName,
                    "age": self.age,
                    "gender": self.gender,
                    "weight": self.weight,
                    "height": self.height,
                    "preferredDiningHall": self.preferredDiningHall,
                    "profileImageUrl": url.absoluteString
                ]
                
                Firestore.firestore().collection("users").addDocument(data: userData) { error in
                    if let error = error {
                        print("Failed to save user data: \(error)")
                    } else {
                        print("User data saved successfully")
                    }
                }
            }
        }
    }*/
