//
//  SignUp.swift
//  TerpMeals
//
//  Created by krisnajit Rajeshkhanna on 6/19/24.
//

import SwiftUI
import PhotosUI

struct SignUp: View {
    @State private var val: String = ""
    @State private var clickedSignIn: Bool = false
    @State private var clickedSignUp: Bool = false
    
    var body: some View {
        if(clickedSignIn){
            SignIn()
        } else if(clickedSignUp) {
          HomeView()
        } else {
            VStack {
                HeaderView()
                                
                VStack {
                    Spacer()
                    
                    InputView(clickedSignUp: $clickedSignUp)
                    //SelectProfileView()
                    
                    Spacer()
                    
                    HStack {
                        Text("Already have an account?")
                        Button(action: {
                            clickedSignIn = true
                        }) {
                            Text("Sign in")
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.bottom, 20)
                }
                .background(.gray.opacity(0.10))
            }
        }
    }
}

struct SelectProfileView: View {
    @State var selected_img: PhotosPickerItem? = nil
    @State var selected_img_data: Data? = nil
    @State var profile_progress = 0
    
    func UIImageConverter(data: Data?) -> UIImage?{
        return UIImage(data: data!)
    }
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $selected_img) {
                if(UIImageConverter(data: selected_img_data) == nil) {
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 5)
                            .foregroundColor(.gray)
                        Circle()
                            .trim(from: 0, to: CGFloat(profile_progress))
                            .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round))
                            .rotationEffect(.degrees(-95))
                            .foregroundColor(.green)
                        Image(systemName: "plus")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                    }
                    .frame(width: 150, height: 150)
                } else {
                    ZStack {
                        Image(uiImage: UIImageConverter(data: selected_img_data)!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                        Circle()
                            .trim(from: 0, to: CGFloat(profile_progress))
                            .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round))
                            .rotationEffect(.degrees(-95))
                            .foregroundColor(.green)
                            .frame(width: 155, height: 155)

                    }
                    .frame(width: 150, height: 150)
                }
            }
            Text("Hello Worldasfafasdfasdfasfsasdfsadfsadfaasdfasdfs")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 20) // Acts as margin
        .padding(.top, 20)
    }
}

struct InputView: View {
    @Binding var clickedSignUp: Bool
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var gender: String = "Select Gender"
    @State private var age: Int = 18
    @State private var weight: Double = 0.0
    @State private var weightUnit: String = "lbs"
    @State private var heightFeet: Int = 5
    @State private var heightInches: Int = 8
    @State private var heightCm: Double = 0.0
    @State private var preferredDiningHall: String = "Select Dining Hall"
    @State private var useImperial: Bool = true
    
    var body: some View {
        VStack(spacing: 15) {
            ScrollView {
                TextField("First Name", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                
                TextField("Last Name", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                
                Picker(selection: $gender, label: Text("Gender")) {
                    Text("Select Gender").tag("Select Gender")
                    Text("Male").tag("Male")
                    Text("Female").tag("Female")
                    Text("Other").tag("Other")
                }
                .pickerStyle(MenuPickerStyle())
                .padding(.horizontal, 20)
                
                HStack {
                    Text("Age: \(age)")
                    Stepper("", value: $age, in: 0...120)
                }
                .padding(.horizontal, 20)
                
                HStack {
                    TextField("Weight", value: $weight, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Picker("Unit", selection: $weightUnit) {
                        Text("lbs").tag("lbs")
                        Text("kg").tag("kg")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.horizontal, 20)
                
                if useImperial {
                    HStack {
                        TextField("Height (ft)", value: $heightFeet, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Height (in)", value: $heightInches, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(.horizontal, 20)
                } else {
                    TextField("Height (cm)", value: $heightCm, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 20)
                }
                
                Toggle("Use Imperial Units", isOn: $useImperial)
                    .padding(.horizontal, 20)
                
                Picker(selection: $preferredDiningHall, label: Text("Preferred Dining Hall")) {
                    Text("Select Dining Hall").tag("Select Dining Hall")
                    Text("Dining Hall 1").tag("Dining Hall 1")
                    Text("Dining Hall 2").tag("Dining Hall 2")
                    Text("Dining Hall 3").tag("Dining Hall 3")
                }
                .pickerStyle(MenuPickerStyle())
                .padding(.horizontal, 20)
                
                Button(action: {
                    // Sign up action
                }) {
                    Text("Sign Up")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 50)
            }
            .frame(maxHeight: 450)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 20) // Acts as margin
        .padding(.top, 20)
    }
}

#Preview {
    SignUp()
}
