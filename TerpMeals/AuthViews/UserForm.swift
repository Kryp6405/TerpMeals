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

//MARK: Q1
struct Q1: View {
    @State private var selected = [false, false, false]
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var userData: UserData

    var allFalseValues: Bool {
        selected.allSatisfy { $0 == false }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Let's get started!")
                    .fontWeight(.thin)
                    .padding(.bottom, 10)
                
                Text("Which dining hall do you prefer?")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                            
                Spacer()
                
                VStack(spacing: 15) {
                    
                    Text("251 North")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[0] ? .white : .red)
                        .foregroundColor(selected[0] ? .red : .white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[0] ? .red : .white, lineWidth: 2)
                        )
                        .onTapGesture {
                            selected[0].toggle()
                            selected[1] = false
                            selected[2] = false
                            if selected[0] {
                                userData.preferredDiningHall = "251 North"
                            }
                        }
                    
                    Text("The Yahentimitsi")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[1] ? .white : .red)
                        .foregroundColor(selected[1] ? .red : .white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[1] ? .red : .white, lineWidth: 2)
                        )
                        .onTapGesture {
                            selected[1].toggle()
                            selected[0] = false
                            selected[2] = false
                            if selected[1] {
                                userData.preferredDiningHall = "The Yahentimitsi"
                            }
                        }

                    Text("South Diner")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[2] ? .white : .red)
                        .foregroundColor(selected[2] ? .red : .white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[2] ? .red : .white, lineWidth: 2)
                        )
                        .onTapGesture {
                            selected[2].toggle()
                            selected[1] = false
                            selected[0] = false
                            if selected[2] {
                                userData.preferredDiningHall = "South Diner"
                            }
                        }
                    
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                NavigationLink(destination: Q2(userData: userData)){
                    Text("Next")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[0] || selected[1] || selected[2] ? .yellow : .gray.opacity(0.2))
                        .foregroundColor(selected[0] || selected[1] || selected[2] ? .white : .black)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                }
                .padding(.horizontal, 20)
                .disabled(allFalseValues)
                
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
                
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 10) {
                        ForEach(0..<8) { i in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(i == 0 ? .yellow : .gray.opacity(0.2))
                                .frame(width: i == 0 ? 50 : 25, height: 5)
                        }
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
        .background(.ultraThickMaterial)
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        var chunks = [[Element]]()
        for index in stride(from: 0, to: count, by: size) {
            let chunk = Array(self[index..<Swift.min(index + size, count)])
            chunks.append(chunk)
        }
        return chunks
    }
}

//MARK: Q2
struct Q2: View {
    @ObservedObject var userData: UserData
    @Environment(\.presentationMode) var presentationMode
    
    @State private var dietaryOptions: [String: Bool] = [
            "Dairy": false,
            "Nuts": false,
            "Eggs": false,
            "Sesame": false,
            "Soy": false,
            "Fish": false,
            "Gluten": false,
            "Shellfish": false,
            "Vegetarian": false,
            "Vegan": false,
            "Halal": false,
            "None": false
        ]

    var body: some View {
        NavigationStack {
            VStack {
                Text("Let's get to know you better!")
                    .fontWeight(.thin)
                    .padding(.bottom, 10)
                
                Text("What are your dietary restrictions or allergies?\nSelect all that apply.")
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                            
                Spacer()
                
                HStack(spacing: 20) {
                    ForEach(Array(dietaryOptions.keys).chunked(into: 6), id: \.self) { column in
                        VStack(spacing: 15) {
                            ForEach(column, id: \.self) { option in
                                DietaryButton(userData: userData, dietaryOptions: $dietaryOptions, text: option)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                NavigationLink(destination: Q3(userData: userData)){
                    Text("Next")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(dietaryOptions.contains { $0.value } ? .yellow : .gray.opacity(0.2))
                        .foregroundColor(dietaryOptions.contains { $0.value } ? .white : .black)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                }
                .padding(.horizontal, 20)
                .disabled(!dietaryOptions.contains { $0.value })
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
                
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 10) {
                        ForEach(0..<8) { i in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(i == 1 ? .yellow : .gray.opacity(0.2))
                                .frame(width: i == 1 ? 50 : 25, height: 5)
                        }
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
        .background(.ultraThickMaterial)
        .onAppear {
            userData.dietaryRestrictions = dietaryOptions
        }
    }
    
    struct DietaryButton: View {
        @ObservedObject var userData: UserData
        @Binding var dietaryOptions: [String: Bool]
        let text: String
        
        var body: some View {
            HStack {
                Spacer()
                Text(text)
                Spacer()
                if dietaryOptions[text]! {
                    Image(systemName: "checkmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 12)
                        .foregroundColor(.red)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(dietaryOptions[text]! ? .white : .red)
            .foregroundColor(dietaryOptions[text]! ? .red : .white)
            .cornerRadius(10)
            .shadow(radius: 1)
            .overlay(
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(dietaryOptions[text]! ? .red : .white, lineWidth: 2)
                }
            )
            .onTapGesture {
                if(text == "None"){
                    for key in dietaryOptions.keys {
                        dietaryOptions[key] = (key == "None")
                        userData.dietaryRestrictions[key] = (key == "None")
                    }
                } else {
                    dietaryOptions[text]?.toggle()
                    userData.dietaryRestrictions[text]?.toggle()
                    if dietaryOptions[text] == true {
                        dietaryOptions["None"] = false
                        userData.dietaryRestrictions["None"] = false
                    }
                }
            }
        }
    }
}


//MARK: Q3
struct Q3: View {
    @ObservedObject var userData: UserData
    @State private var selected: [Bool] = [false, false]
    @Environment(\.presentationMode) var presentationMode

    var allFalseValues: Bool {
        selected.allSatisfy { $0 == false }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("We can help you!")
                    .fontWeight(.thin)
                    .padding(.bottom, 10)
                
                Text("Which sex should we consider when calculating your recommendations?")
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                            
                Spacer()
                
                VStack(spacing: 15) {
                    Text("Female")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[0] ? .white : .red)
                        .foregroundColor(selected[0] ? .red : .white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[0] ? .red : .white, lineWidth: 2)
                        )
                        .onTapGesture {
                            selected[0].toggle()
                            selected[1] = false
                            if selected[0] {
                                userData.gender = "Female"
                            }
                        }
                    
                    
                    Text("Male")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[1] ? .white : .red)
                        .foregroundColor(selected[1] ? .red : .white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[1] ? .red : .white, lineWidth: 2)
                        )
                        .onTapGesture {
                            selected[1].toggle()
                            selected[0] = false
                            if selected[1] {
                                userData.gender = "Male"
                            }
                        }
                    
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                NavigationLink(destination: Q4(userData: userData)){
                    Text("Next")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[0] || selected[1] ? .yellow : .gray.opacity(0.2))
                        .foregroundColor(selected[0] || selected[1] ? .white : .black)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                }
                .padding(.horizontal, 20)
                .disabled(allFalseValues)

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
                
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 10) {
                        ForEach(0..<8) { i in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(i == 2 ? .yellow : .gray.opacity(0.2))
                                .frame(width: i == 2 ? 50 : 25, height: 5)
                        }
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
        .background(.ultraThickMaterial)
    }
}

//MARK: Q4
struct Q4: View {
    @ObservedObject var userData: UserData
    @State private var selectedMonth = "July"
    @State private var selectedDay = 18
    @State private var selectedYear = 2024
    @Environment(\.presentationMode) var presentationMode

    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    let years = Array(1980...2024)
    
    func isLeapYear(_ year: Int) -> Bool {
        (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
    }
    
    var days: [Int] {
            switch selectedMonth {
            case "January", "March", "May", "July", "August", "October", "December":
                return Array(1...31)
            case "April", "June", "September", "November":
                return Array(1...30)
            case "February":
                return isLeapYear(selectedYear) ? Array(1...29) : Array(1...28)
            default:
                return Array(1...31)
            }
        }
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Next steps...")
                    .fontWeight(.thin)
                    .padding(.bottom, 10)
                
                Text("What is your birthdate?")
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                
                Spacer()
            
                HStack {
                    Spacer().frame(width: 20)

                    Picker("Month", selection: $selectedMonth) {
                        ForEach(months, id: \.self) { month in
                            Text(month)
                                .tag(month)
                                .foregroundColor(month == selectedMonth ? .white : .primary)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(maxWidth: .infinity)
                    
                    Picker("Day", selection: $selectedDay) {
                        ForEach(days, id: \.self) { day in
                            Text("\(day)")
                                .tag(day)
                                .foregroundColor(day == selectedDay ? .white : .primary)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(maxWidth: .infinity)
                    
                    Picker("Year", selection: $selectedYear) {
                        ForEach(years, id: \.self) { year in
                            Text(numberFormatter.string(from: NSNumber(value: year)) ?? "\(year)")
                                .tag(year)
                                .foregroundColor(year == selectedYear ? .white : .primary)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(maxWidth: .infinity)
                    
                    Spacer().frame(width: 20)
                }
                .padding()
                .background(
                    ZStack {
                        Color.white
                        
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.red.opacity(0.8))
                            .frame(height: 40)
                            .padding(.horizontal, 15)
                    }
                    .padding(.horizontal, 20)
                )
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.red, lineWidth: 2)
                        .padding(.horizontal, 20)
                )
            
                
                Spacer()
                
                NavigationLink(destination: Q5(userData: userData)){
                    Text("Next")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.yellow)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                }
                .padding(.horizontal, 20)
                .simultaneousGesture(TapGesture().onEnded {
                    
                    var components = DateComponents()
                    components.year = selectedYear
                    components.month = months.firstIndex(of: selectedMonth)! + 1
                    components.day = selectedDay

                    if let birthday = Calendar.current.date(from: components) {
                        userData.birthday = birthday
                        
                        // Calculate age
                        let calendar = Calendar.current
                        let currentDate = Date()
                        let ageComponents = calendar.dateComponents([.year], from: birthday, to: currentDate)
                        if let age = ageComponents.year {
                            print("Age is \(age)")
                            userData.age = age
                        } else {
                            print("Unable to calculate age")
                        }
                    } else {
                        print("Invalid date components")
                    }
                })

            }
            .background(.ultraThickMaterial)
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
                
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 10) {
                        ForEach(0..<8) { i in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(i == 3 ? .yellow : .gray.opacity(0.2))
                                .frame(width: i == 3 ? 50 : 25, height: 5)
                        }
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

//MARK: Q5
struct Q5: View {
    @ObservedObject var userData: UserData
    @State private var ft = 5
    @State private var inc = 8
    @State private var cm = 177
    @State private var mm = 6
    @State private var isImperial: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    let feetRange = Array(3...8)
    let inchesRange = Array(0...11)
    let centimetersRange = Array(0...300)
    let millimetersRange = Array(0...9)
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Next steps...")
                    .fontWeight(.thin)
                    .padding(.bottom, 10)
                
                Text("What is your height?")
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                            
                Spacer()

                if !isImperial {
                    HStack {
                        Spacer().frame(width: 20)

                        HStack {
                            Picker("Feet", selection: $ft) {
                                ForEach(feetRange, id: \.self) { feet in
                                    Text("\(feet)")
                                        .tag(feet)
                                        .foregroundColor(feet == ft ? .white : .primary)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(maxWidth: .infinity)
                            Text("'")
                                .foregroundColor(.white)
                            Spacer()
                        }
                        
                        HStack {
                            Picker("Inches", selection: $inc) {
                                ForEach(inchesRange, id: \.self) { inch in
                                    Text("\(inch)")
                                        .tag(inch)
                                        .foregroundColor(inch == inc ? .white : .primary)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(maxWidth: .infinity)
                            Text("\"")
                                .foregroundColor(.white)
                            Spacer()
                        }
                        
                        Picker("Units", selection: $isImperial) {
                            Text("ft/in")
                                .tag(false)
                                .foregroundColor(.white)
                            Text("cm")
                                .tag(true)
                        }
                        .pickerStyle(.wheel)
                        .foregroundColor(.white)
                        
                        Spacer().frame(width: 20)
                    }
                    .padding()
                    .background(
                        ZStack {
                            Color.white
                            
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.red.opacity(0.8))
                                .frame(height: 40)
                                .padding(.horizontal, 15)
                        }
                        .padding(.horizontal, 20)
                    )
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.red, lineWidth: 2)
                            .padding(.horizontal, 20)
                    )
                } else {
                    HStack {
                        Spacer().frame(width: 20)

                        HStack {
                            Picker("Centimeters", selection: $cm) {
                                ForEach(centimetersRange, id: \.self) { cmt in
                                    Text("\(cmt)")
                                        .tag(cmt)
                                        .foregroundColor(cmt == cm ? .white : .primary)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(maxWidth: .infinity)
                            Text(".")
                                .foregroundColor(.white)
                            Spacer()
                        }
                        
                        Picker("Millimeters", selection: $mm) {
                            ForEach(millimetersRange, id: \.self) { mmt in
                                Text("\(mmt)")
                                    .tag(mmt)
                                    .foregroundColor(mmt == mm ? .white : .primary)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(maxWidth: .infinity)
                        
                        Picker("Units", selection: $isImperial) {
                            Text("ft/in").tag(false)
                            Text("cm").tag(true)
                                .foregroundColor(.white)
                        }
                        .pickerStyle(.wheel)
                        .foregroundColor(.white)
                        
                        Spacer().frame(width: 20)
                    }
                    .padding()
                    .background(
                        ZStack {
                            Color.white
                            
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.red.opacity(0.8))
                                .frame(height: 40)
                                .padding(.horizontal, 15)
                        }
                        .padding(.horizontal, 20)
                    )
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.red, lineWidth: 2)
                            .padding(.horizontal, 20)
                    )
                }
                
                Spacer()
                
                NavigationLink(destination: Q6(userData: userData)){
                    Text("Next")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.yellow)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                }
                .padding(.horizontal, 20)
                .simultaneousGesture(TapGesture().onEnded {
                    var height: Double = 0
                    if !isImperial {
                        height = Double((12 * ft) + inc)
                        userData.heightMeasurement = "Inches"
                    } else {
                        height = Double(cm) + (0.1 * Double(mm))
                        userData.heightMeasurement = "Centimeters"
                    }
                    
                    userData.height = height
                })
            }
            .background(.ultraThickMaterial)
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
                
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 10) {
                        ForEach(0..<8) { i in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(i == 4 ? .yellow : .gray.opacity(0.2))
                                .frame(width: i == 4 ? 50 : 25, height: 5)
                        }
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

//MARK: Q6
struct Q6: View {
    @ObservedObject var userData: UserData
    @State private var lbs = 150
    @State private var lbsInc = 7
    @State private var kg = 70
    @State private var g = 3
    @State private var isImperial: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    let poundsRange = Array(50...400)
    let poundsIncRange = Array(0...9)
    let kilogramsRange = Array(20...180)
    let gramsRange = Array(0...9)
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Next steps...")
                    .fontWeight(.thin)
                    .padding(.bottom, 10)
                
                Text("What is your weight?")
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                            
                Spacer()
                
                if !isImperial {
                    HStack {
                        Spacer().frame(width: 20)

                        HStack {
                            Picker("Pounds", selection: $lbs) {
                                ForEach(poundsRange, id: \.self) { lb in
                                    Text("\(lb)")
                                        .tag(lb)
                                        .foregroundColor(lb == lbs ? .white : .primary)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(maxWidth: .infinity)
                            Text(".")
                                .foregroundColor(.white)
                            Spacer()
                        }
                        
                        Picker("Pound Inc.", selection: $lbsInc) {
                            ForEach(poundsIncRange, id: \.self) { lbIn in
                                Text("\(lbIn)")
                                    .tag(lbIn)
                                    .foregroundColor(lbIn == lbsInc ? .white : .primary)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(maxWidth: .infinity)
                        
                        Picker("Units", selection: $isImperial) {
                            Text("lbs").tag(false)
                            Text("kg").tag(true)
                                .foregroundColor(.white)
                        }
                        .pickerStyle(.wheel)
                        .foregroundColor(.white)
                        
                        Spacer().frame(width: 20)
                    }
                    .padding()
                    .background(
                        ZStack {
                            Color.white
                            
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.red.opacity(0.8))
                                .frame(height: 40)
                                .padding(.horizontal, 15)
                        }
                        .padding(.horizontal, 20)
                    )
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.red, lineWidth: 2)
                            .padding(.horizontal, 20)
                    )
                } else {
                    HStack {
                        Spacer().frame(width: 20)

                        HStack {
                            Picker("Kilograms", selection: $kg) {
                                ForEach(kilogramsRange, id: \.self) { kgs in
                                    Text("\(kgs)")
                                        .tag(kgs)
                                        .foregroundColor(kgs == kg ? .white : .primary)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(maxWidth: .infinity)
                            Text(".")
                                .foregroundColor(.white)
                            Spacer()
                        }
                        
                        Picker("Grams", selection: $g) {
                            ForEach(gramsRange, id: \.self) { gs in
                                Text("\(gs)")
                                    .tag(gs)
                                    .foregroundColor(gs == g ? .white : .primary)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(maxWidth: .infinity)
                        
                        Picker("Units", selection: $isImperial) {
                            Text("lbs").tag(false)
                            Text("kg").tag(true)
                                .foregroundColor(.white)
                        }
                        .pickerStyle(.wheel)
                        .foregroundColor(.white)
                        
                        Spacer().frame(width: 20)
                    }
                    .padding()
                    .background(
                        ZStack {
                            Color.white
                            
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.red.opacity(0.8))
                                .frame(height: 40)
                                .padding(.horizontal, 15)
                        }
                        .padding(.horizontal, 20)
                    )
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.red, lineWidth: 2)
                            .padding(.horizontal, 20)
                    )
                }

                Spacer()
                
                NavigationLink(destination: Q7(userData: userData)){
                    Text("Next")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.yellow)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                }
                .padding(.horizontal, 20)
                .simultaneousGesture(TapGesture().onEnded {
                    var weight: Double = 0
                    if !isImperial {
                        weight = Double(lbs) + (0.1 * Double(lbsInc))
                        userData.weightMeasurement = "Pounds"
                    } else {
                        weight = Double(kg) + (0.1 * Double(g))
                        userData.weightMeasurement = "Kilograms"
                    }
                    
                    userData.weight = weight
                })
            }
            .background(.ultraThickMaterial)
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
                
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 10) {
                        ForEach(0..<8) { i in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(i == 5 ? .yellow : .gray.opacity(0.2))
                                .frame(width: i == 5 ? 50 : 25, height: 5)
                        }
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

//MARK: Q7
struct Q7: View {
    @ObservedObject var userData: UserData
    @State private var selected = [false, false, false]
    @Environment(\.presentationMode) var presentationMode

    var allFalseValues: Bool {
        selected.allSatisfy { $0 == false }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Next Steps..")
                    .fontWeight(.thin)
                    .padding(.bottom, 10)
                
                Text("What is your weight goal")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                            
                Spacer()
                
                VStack(spacing: 15) {
                    
                    Text("Lose Weight")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[0] ? .white : .red)
                        .foregroundColor(selected[0] ? .red : .white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[0] ? .red : .white, lineWidth: 2)
                        )
                        .onTapGesture {
                            selected[0].toggle()
                            selected[1] = false
                            selected[2] = false
                            if selected[0] {
                                userData.goal = "Lose Weight"
                            }
                        }
                    
                    Text("Maintain Weight")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[1] ? .white : .red)
                        .foregroundColor(selected[1] ? .red : .white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[1] ? .red : .white, lineWidth: 2)
                        )
                        .onTapGesture {
                            selected[1].toggle()
                            selected[0] = false
                            selected[2] = false
                            if selected[1] {
                                userData.goal = "Maintain Weight"
                            }
                        }

                    Text("Gain Weight")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[2] ? .white : .red)
                        .foregroundColor(selected[2] ? .red : .white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[2] ? .red : .white, lineWidth: 2)
                        )
                        .onTapGesture {
                            selected[2].toggle()
                            selected[1] = false
                            selected[0] = false
                            if selected[2] {
                                userData.goal = "Gain Weight"
                            }
                        }
                    
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                NavigationLink(destination: Q8(userData: userData)){
                    Text("Next")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[0] || selected[1] || selected[2] ? .yellow : .gray.opacity(0.2))
                        .foregroundColor(selected[0] || selected[1] || selected[2] ? .white : .black)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                }
                .padding(.horizontal, 20)
                .disabled(allFalseValues)
                
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
                
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 10) {
                        ForEach(0..<8) { i in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(i == 6 ? .yellow : .gray.opacity(0.2))
                                .frame(width: i == 6 ? 50 : 25, height: 5)
                        }
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
        .background(.ultraThickMaterial)
    }
}

//MARK: Q8
struct Q8: View {
    @ObservedObject var userData: UserData
    @State private var selected = [false, false, false, false, false]
    @Environment(\.presentationMode) var presentationMode

    var allFalseValues: Bool {
        selected.allSatisfy { $0 == false }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Next Steps..")
                    .fontWeight(.thin)
                    .padding(.bottom, 10)
                
                Text("What is your activity level")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                            
                Spacer()
                
                VStack(spacing: 15) {
                    
                    Text("Sedentary (little or no exercise)")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[0] ? .white : .red)
                        .foregroundColor(selected[0] ? .red : .white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[0] ? .red : .white, lineWidth: 2)
                        )
                        .onTapGesture {
                            selected[0].toggle()
                            selected[1] = false
                            selected[2] = false
                            selected[3] = false
                            selected[4] = false
                            if selected[0] {
                                userData.activityLevel = 1.2
                            }
                        }
                    
                    Text("Lightly active (light exercise/sports 1-3 days/week)")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[1] ? .white : .red)
                        .foregroundColor(selected[1] ? .red : .white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[1] ? .red : .white, lineWidth: 2)
                        )
                        .onTapGesture {
                            selected[0] = false
                            selected[1].toggle()
                            selected[2] = false
                            selected[3] = false
                            selected[4] = false
                            if selected[1] {
                                userData.activityLevel = 1.375
                            }
                        }

                    Text("Moderately active (moderate exercise/sports 3-5 days/week)")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[2] ? .white : .red)
                        .foregroundColor(selected[2] ? .red : .white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[2] ? .red : .white, lineWidth: 2)
                        )
                        .onTapGesture {
                            selected[0] = false
                            selected[1] = false
                            selected[2].toggle()
                            selected[3] = false
                            selected[4] = false
                            if selected[2] {
                                userData.activityLevel = 1.55
                            }
                        }
                    
                    Text("Very active (hard exercise/sports 6-7 days a week)")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[3] ? .white : .red)
                        .foregroundColor(selected[3] ? .red : .white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[3] ? .red : .white, lineWidth: 2)
                        )
                        .onTapGesture {
                            selected[0] = false
                            selected[1] = false
                            selected[2] = false
                            selected[3].toggle()
                            selected[4] = false
                            if selected[3] {
                                userData.activityLevel = 1.725
                            }
                        }
                    
                    Text("Extra active (very hard exercise/sports & a physical job)")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[4] ? .white : .red)
                        .foregroundColor(selected[4] ? .red : .white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[4] ? .red : .white, lineWidth: 2)
                        )
                        .onTapGesture {
                            selected[0] = false
                            selected[1] = false
                            selected[2] = false
                            selected[3] = false
                            selected[4].toggle()
                            if selected[4] {
                                userData.activityLevel = 1.9
                            }
                        }
                    
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                NavigationLink(destination: SignupPrev(userData: userData)){
                    Text("Next")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[0] || selected[1] || selected[2] || selected[3] || selected[4] ? .yellow : .gray.opacity(0.2))
                        .foregroundColor(selected[0] || selected[1] || selected[2] || selected[3] || selected[4] ? .white : .black)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                }
                .padding(.horizontal, 20)
                .disabled(allFalseValues)
                
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
                
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 10) {
                        ForEach(0..<8) { i in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(i == 7 ? .yellow : .gray.opacity(0.2))
                                .frame(width: i == 7 ? 50 : 25, height: 5)
                        }
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
        .background(.ultraThickMaterial)
    }
}

//MARK: Old UserForm
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
        Q1(userData: UserData())
    }
}

#Preview {
    Q1(userData: UserData())
}
