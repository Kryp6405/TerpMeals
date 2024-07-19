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

struct Q1: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationStack {
            VStack {
                Text("Let's get started!")
                Text("Which dining hall do you prefer?")
                            
                Spacer()
                
                VStack {
                    Button(action: {}) {
                        Text("251 North")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(radius: 1)
                    }
                    
                    
                    Button(action: {}){
                        Text("The Yahentimitsi")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(radius: 1)
                    }
                    
                    Button(action: {}){
                        Text("South Diner")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(radius: 1)
                    }
                }
                
                Spacer()
                
                NavigationLink(destination: Q2()){
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                }

            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        DispatchQueue.main.async {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Image(systemName: "chevron.backward")
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
}

struct Q2: View {
    @Environment(\.presentationMode) var presentationMode
    
    let dietaryOptions = [
        ["Dairy", "Nuts", "Eggs", "Sesame", "Soy", "Fish"],
        ["Gluten", "Shellfish", "Vegetarian", "Vegan", "Halal", "None"]
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Let's get to know you better!")
                Text("What are your dietary restrictions or allergies? Select all that apply.")
                    .multilineTextAlignment(.center)
                            
                Spacer()
                
                HStack {
                    ForEach(dietaryOptions, id: \.self) { column in
                        VStack {
                            ForEach(column, id: \.self) { option in
                                DietaryButton(text: option)
                            }
                        }
                    }
                }
                
                Spacer()
                
                NavigationLink(destination: Q3()) {
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        DispatchQueue.main.async {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Image(systemName: "chevron.backward")
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
    
    struct DietaryButton: View {
        let text: String
        
        var body: some View {
            Button(action: {}) {
                Text(text)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .shadow(radius: 1)
            }
        }
    }
}



struct Q3: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationStack {
            VStack {
                Text("We can help you!")
                Text("Which sex should we consider when calculating your personalized recommendations?")
                            
                Spacer()
                
                VStack {
                    Button(action: {}) {
                        Text("Male")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(radius: 1)
                    }
                    
                    
                    Button(action: {}){
                        Text("Female")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(radius: 1)
                    }
                }
                
                Spacer()
                
                NavigationLink(destination: Q4()){
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                }

            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        DispatchQueue.main.async {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Image(systemName: "chevron.backward")
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
}

struct Q4: View {
    @State private var month: String = ""
    @State private var day: String = ""
    @State private var year: String = ""
    @State private var dob: Date = Date()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Next step")
                Text("What is your birthdate?")
                            
                Spacer()
                
                HStack {
                    DatePicker(
                        "Select Date",
                        selection: $dob,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    
                }
                
                Spacer()
                
                NavigationLink(destination: Q5()){
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                }

            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        DispatchQueue.main.async {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Image(systemName: "chevron.backward")
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
}

struct Q5: View {
    @State private var ft = 5
    @State private var inc = 7
    @State private var cm = 170
    @State private var mm = 0
    @State private var isImperial: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    let feetRange = Array(3...8)
    let inchesRange = Array(0...11)
    let centimetersRange = Array(0...300)
    let millimetersRange = Array(0...9)
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Next step")
                Text("What is your height?")
                            
                Spacer()
                
                Picker("Units", selection: $isImperial) {
                    Text("ft/in").tag(false)
                    Text("cm").tag(true)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                if !isImperial {
                    HStack {
                        Picker("Feet", selection: $ft) {
                            ForEach(feetRange, id: \.self) { feet in
                                Text("\(feet) ft")
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 100, height: 150)
                        .clipped()

                        Picker("Inches", selection: $inc) {
                            ForEach(inchesRange, id: \.self) { inches in
                                Text("\(inches) in")
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 100, height: 150)
                        .clipped()
                    }
                } else {
                    // Metric View
                    HStack {
                        Picker("Centimeters", selection: $cm) {
                            ForEach(centimetersRange, id: \.self) { cm in
                                Text("\(cm) cm")
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 100, height: 150)
                        .clipped()

                        Picker("Millimeters", selection: $mm) {
                            ForEach(millimetersRange, id: \.self) { mm in
                                Text("\(mm) mm")
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 100, height: 150)
                        .clipped()
                    }
                }
                
                Spacer()
                
                NavigationLink(destination: Q6()){
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                }

            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        DispatchQueue.main.async {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Image(systemName: "chevron.backward")
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
}

struct Q6: View {
    @State private var lbs = 150
    @State private var kg = 70
    @State private var isImperial: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    let poundsRange = Array(50...400)
    let kilogramsRange = Array(20...180)
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Next step")
                Text("What is your height?")
                            
                Spacer()
                // Unit Toggle
                Picker("Units", selection: $isImperial) {
                    Text("Imperial").tag(false)
                    Text("Metric").tag(true)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // Imperial View
                if !isImperial {
                    Picker("Pounds", selection: $lbs) {
                        ForEach(poundsRange, id: \.self) { lbs in
                            Text("\(lbs) lbs")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 150, height: 150)
                    .clipped()
                } else {
                    // Metric View
                    Picker("Kilograms", selection: $kg) {
                        ForEach(kilogramsRange, id: \.self) { kg in
                            Text("\(kg) kg")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 150, height: 150)
                    .clipped()
                }

                Spacer()
                
                NavigationLink(destination: SignupPrev()){
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        DispatchQueue.main.async {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Image(systemName: "chevron.backward")
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
}



//MARK: Current UserForm
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
        NavigationStack {
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
                        AuthenticationModel().signOutAndDeleteUser { error in
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
        Q5()
    }
}

#Preview {
    Q5()
}
