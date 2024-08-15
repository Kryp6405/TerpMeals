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
                        .background(selected[0] ? Color(.light) : Color(.accent))
                        .foregroundColor(selected[0] ? Color(.accent) : Color(.light))
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[0] ? Color(.accent) : Color(.light), lineWidth: 2)
                        )
                        .onTapGesture {
                            selected[0].toggle()
                            selected[1] = false
                            selected[2] = false
                            userData.preferredDiningHall = "251 North"
                        }
                    
                    Text("The Yahentimitsi")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[1] ? Color(.light) : Color(.accent))
                        .foregroundColor(selected[1] ? Color(.accent) : Color(.light))
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[1] ? Color(.accent) : Color(.light), lineWidth: 2)
                        )
                        .onTapGesture {
                            selected[1].toggle()
                            selected[0] = false
                            selected[2] = false
                            userData.preferredDiningHall = "The Yahentimitsi"
                        }

                    Text("South Diner")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[2] ? Color(.light) : Color(.accent))
                        .foregroundColor(selected[2] ? Color(.accent) : Color(.light))
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[2] ? Color(.accent) : Color(.light), lineWidth: 2)
                        )
                        .onTapGesture {
                            selected[2].toggle()
                            selected[1] = false
                            selected[0] = false
                            userData.preferredDiningHall = "South Diner"
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
                        .foregroundColor(selected[0] || selected[1] || selected[2] ? Color(.light) :Color(.dark))
                        .cornerRadius(10)
                        .shadow(radius: 1)
                }
                .padding(.horizontal, 20)
                .disabled(allFalseValues)
                
            }
            .background(Color(.light))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        DispatchQueue.main.async {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color(.accent))
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
                            .foregroundColor(Color(.accent))
                    }
                }
            }
        }
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
                    ForEach(Array(dietaryOptions.keys.sorted()).chunked(into: 6), id: \.self) { column in
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
                        .foregroundColor(dietaryOptions.contains { $0.value } ? Color(.light) :Color(.dark))
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
                            .foregroundColor(Color(.accent))
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
                            .foregroundColor(Color(.accent))
                    }
                }
            }
        }
        .background(Color(.light))
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
                        .foregroundColor(Color(.accent))
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(dietaryOptions[text]! ? Color(.light) : Color(.accent))
            .foregroundColor(dietaryOptions[text]! ? Color(.accent) : Color(.light))
            .cornerRadius(10)
            .shadow(radius: 1)
            .overlay(
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(dietaryOptions[text]! ? Color(.accent) : Color(.light), lineWidth: 2)
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
                        .background(selected[0] ? Color(.light) : Color(.accent))
                        .foregroundColor(selected[0] ? Color(.accent) : Color(.light))
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[0] ? Color(.accent) : Color(.light), lineWidth: 2)
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
                        .background(selected[1] ? Color(.light) : Color(.accent))
                        .foregroundColor(selected[1] ? Color(.accent) : Color(.light))
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[1] ? Color(.accent) : Color(.light), lineWidth: 2)
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
                        .foregroundColor(selected[0] || selected[1] ? Color(.light) :Color(.dark))
                        .cornerRadius(10)
                        .shadow(radius: 1)
                }
                .padding(.horizontal, 20)
                .disabled(allFalseValues)

            }
            .background(Color(.light))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        DispatchQueue.main.async {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color(.accent))
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
                            .foregroundColor(Color(.accent))
                    }
                }
            }
        }
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
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                
                Spacer()
            
                HStack {
                    Spacer().frame(width: 20)

                    Picker("Month", selection: $selectedMonth) {
                        ForEach(months, id: \.self) { month in
                            Text(month)
                                .tag(month)
                                .foregroundColor(month == selectedMonth ? Color(.light) : .primary)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(maxWidth: .infinity)
                    
                    Picker("Day", selection: $selectedDay) {
                        ForEach(days, id: \.self) { day in
                            Text("\(day)")
                                .tag(day)
                                .foregroundColor(day == selectedDay ? Color(.light) : .primary)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(maxWidth: .infinity)
                    
                    Picker("Year", selection: $selectedYear) {
                        ForEach(years, id: \.self) { year in
                            Text(numberFormatter.string(from: NSNumber(value: year)) ?? "\(year)")
                                .tag(year)
                                .foregroundColor(year == selectedYear ? Color(.light) : .primary)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(maxWidth: .infinity)
                    
                    Spacer().frame(width: 20)
                }
                .padding()
                .background(
                    ZStack {
                        Color(.light)
                        
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.accent).opacity(0.8))
                            .frame(height: 40)
                            .padding(.horizontal, 15)
                    }
                    .padding(.horizontal, 20)
                )
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.accent), lineWidth: 2)
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
                        .foregroundColor(Color(.light))
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
            .background(Color(.light))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        DispatchQueue.main.async {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color(.accent))
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
                            .foregroundColor(Color(.accent))
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
                    .font(.largeTitle)
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
                                        .foregroundColor(feet == ft ? Color(.light) : .primary)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(maxWidth: .infinity)
                            Text("'")
                                .foregroundColor(Color(.light))
                            Spacer()
                        }
                        
                        HStack {
                            Picker("Inches", selection: $inc) {
                                ForEach(inchesRange, id: \.self) { inch in
                                    Text("\(inch)")
                                        .tag(inch)
                                        .foregroundColor(inch == inc ? Color(.light) : .primary)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(maxWidth: .infinity)
                            Text("\"")
                                .foregroundColor(Color(.light))
                            Spacer()
                        }
                        
                        Picker("Units", selection: $isImperial) {
                            Text("ft/in")
                                .tag(false)
                                .foregroundColor(Color(.light))
                            Text("cm")
                                .tag(true)
                        }
                        .pickerStyle(.wheel)
                        .foregroundColor(Color(.light))
                        
                        Spacer().frame(width: 20)
                    }
                    .padding()
                    .background(
                        ZStack {
                            Color(.light)
                            
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(.accent).opacity(0.8))
                                .frame(height: 40)
                                .padding(.horizontal, 15)
                        }
                        .padding(.horizontal, 20)
                    )
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.accent), lineWidth: 2)
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
                                        .foregroundColor(cmt == cm ? Color(.light) : .primary)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(maxWidth: .infinity)
                            Text(".")
                                .foregroundColor(Color(.light))
                            Spacer()
                        }
                        
                        Picker("Millimeters", selection: $mm) {
                            ForEach(millimetersRange, id: \.self) { mmt in
                                Text("\(mmt)")
                                    .tag(mmt)
                                    .foregroundColor(mmt == mm ? Color(.light) : .primary)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(maxWidth: .infinity)
                        
                        Picker("Units", selection: $isImperial) {
                            Text("ft/in").tag(false)
                            Text("cm").tag(true)
                                .foregroundColor(Color(.light))
                        }
                        .pickerStyle(.wheel)
                        .foregroundColor(Color(.light))
                        
                        Spacer().frame(width: 20)
                    }
                    .padding()
                    .background(
                        ZStack {
                            Color(.light)
                            
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(.accent).opacity(0.9))
                                .frame(height: 40)
                                .padding(.horizontal, 15)
                        }
                        .padding(.horizontal, 20)
                    )
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.accent), lineWidth: 2)
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
                        .foregroundColor(Color(.light))
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
            .background(Color(.light))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        DispatchQueue.main.async {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color(.accent))
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
                            .foregroundColor(Color(.accent))
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
                Text("Getting Closer...")
                    .fontWeight(.thin)
                    .padding(.bottom, 10)
                
                Text("What is your weight?")
                    .font(.largeTitle)
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
                                        .foregroundColor(lb == lbs ? Color(.light) : .primary)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(maxWidth: .infinity)
                            Text(".")
                                .foregroundColor(Color(.light))
                            Spacer()
                        }
                        
                        Picker("Pound Inc.", selection: $lbsInc) {
                            ForEach(poundsIncRange, id: \.self) { lbIn in
                                Text("\(lbIn)")
                                    .tag(lbIn)
                                    .foregroundColor(lbIn == lbsInc ? Color(.light) : .primary)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(maxWidth: .infinity)
                        
                        Picker("Units", selection: $isImperial) {
                            Text("lbs").tag(false)
                            Text("kg").tag(true)
                                .foregroundColor(Color(.light))
                        }
                        .pickerStyle(.wheel)
                        .foregroundColor(Color(.light))
                        
                        Spacer().frame(width: 20)
                    }
                    .padding()
                    .background(
                        ZStack {
                            Color(.light)
                            
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(.accent).opacity(0.9))
                                .frame(height: 40)
                                .padding(.horizontal, 15)
                        }
                        .padding(.horizontal, 20)
                    )
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.accent), lineWidth: 2)
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
                                        .foregroundColor(kgs == kg ? Color(.light) : .primary)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(maxWidth: .infinity)
                            Text(".")
                                .foregroundColor(Color(.light))
                            Spacer()
                        }
                        
                        Picker("Grams", selection: $g) {
                            ForEach(gramsRange, id: \.self) { gs in
                                Text("\(gs)")
                                    .tag(gs)
                                    .foregroundColor(gs == g ? Color(.light) : .primary)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(maxWidth: .infinity)
                        
                        Picker("Units", selection: $isImperial) {
                            Text("lbs").tag(false)
                            Text("kg").tag(true)
                                .foregroundColor(Color(.light))
                        }
                        .pickerStyle(.wheel)
                        .foregroundColor(Color(.light))
                        
                        Spacer().frame(width: 20)
                    }
                    .padding()
                    .background(
                        ZStack {
                            Color(.light)
                            
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(.accent).opacity(0.9))
                                .frame(height: 40)
                                .padding(.horizontal, 15)
                        }
                        .padding(.horizontal, 20)
                    )
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.accent), lineWidth: 2)
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
                        .foregroundColor(Color(.light))
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
            .background(Color(.light))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        DispatchQueue.main.async {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color(.accent))
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
                            .foregroundColor(Color(.accent))
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
                Text("Almost There...")
                    .fontWeight(.thin)
                    .padding(.bottom, 10)
                
                Text("What is your weight goal?")
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
                        .background(selected[0] ? Color(.light) : Color(.accent))
                        .foregroundColor(selected[0] ? Color(.accent) : Color(.light))
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[0] ? Color(.accent) : Color(.light), lineWidth: 2)
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
                        .background(selected[1] ? Color(.light) : Color(.accent))
                        .foregroundColor(selected[1] ? Color(.accent) : Color(.light))
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[1] ? Color(.accent) : Color(.light), lineWidth: 2)
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
                        .background(selected[2] ? Color(.light) : Color(.accent))
                        .foregroundColor(selected[2] ? Color(.accent) : Color(.light))
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[2] ? Color(.accent) : Color(.light), lineWidth: 2)
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
                        .foregroundColor(selected[0] || selected[1] || selected[2] ? Color(.light) :Color(.dark))
                        .cornerRadius(10)
                        .shadow(radius: 1)
                }
                .padding(.horizontal, 20)
                .disabled(allFalseValues)
                
            }
            .background(Color(.light))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        DispatchQueue.main.async {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color(.accent))
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
                            .foregroundColor(Color(.accent))
                    }
                }
            }
        }
    }
}

//MARK: Q8
struct Q8: View {
    @ObservedObject var userData: UserData
    @State private var selected = [false, false, false, false, false]
    @State private var showDesc = false
    @Environment(\.presentationMode) var presentationMode

    var allFalseValues: Bool {
        selected.allSatisfy { $0 == false }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Last One!")
                    .fontWeight(.thin)
                    .padding(.bottom, 10)
                
                Text("What is your activity level?")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                            
                Spacer()
                
                VStack(spacing: 15) {
                    
                    Text("Sedentary")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[0] ? Color(.light) : Color(.accent))
                        .foregroundColor(selected[0] ? Color(.accent) : Color(.light))
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[0] ? Color(.accent) : Color(.light), lineWidth: 2)
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
                    
                    Text("Lightly Active")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[1] ? Color(.light) : Color(.accent))
                        .foregroundColor(selected[1] ? Color(.accent) : Color(.light))
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[1] ? Color(.accent) : Color(.light), lineWidth: 2)
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

                    Text("Moderately Active")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[2] ? Color(.light) : Color(.accent))
                        .foregroundColor(selected[2] ? Color(.accent) : Color(.light))
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[2] ? Color(.accent) : Color(.light), lineWidth: 2)
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
                    
                    Text("Very Active")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[3] ? Color(.light) : Color(.accent))
                        .foregroundColor(selected[3] ? Color(.accent) : Color(.light))
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[3] ? Color(.accent) : Color(.light), lineWidth: 2)
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
                    
                    Text("Extra Active")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[4] ? Color(.light) : Color(.accent))
                        .foregroundColor(selected[4] ? Color(.accent) : Color(.light))
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selected[4] ? Color(.accent) : Color(.light), lineWidth: 2)
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
                
                Button(action: {
                    showDesc.toggle()
                }) {
                    Text("What do the activity levels mean?")
                        .font(.caption)
                        .underline(true)
                        .foregroundColor(.gray)
                        .padding()
                }
                .padding(.horizontal, 10)
                .sheet(isPresented: $showDesc){
                    ScrollView{
                        Spacer()
                            .frame(height: 40)
                        
                        VStack{
                            Text("What do the activity levels mean?")
                                .font(.title)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                            Text("little or no exercise")
                            Text("light exercise/sports 1-3 days/week")
                            Text("moderate exercise/sports 3-5 days/week")
                            Text("hard exercise/sports 6-7 days a week")
                            Text("very hard exercise/sports & a physical job")
                        }
                    }
                    .background(Color(.light))
                    .presentationDetents([.fraction(0.5)])
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(25)
                }
                
                NavigationLink(destination: SignupPrev(userData: userData)){
                    Text("Next")
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected[0] || selected[1] || selected[2] || selected[3] || selected[4] ? .yellow : .gray.opacity(0.2))
                        .foregroundColor(selected[0] || selected[1] || selected[2] || selected[3] || selected[4] ? Color(.light) :Color(.dark))
                        .cornerRadius(10)
                        .shadow(radius: 1)
                }
                .padding(.horizontal, 20)
                .disabled(allFalseValues)
                
            }
            .background(Color(.light))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        DispatchQueue.main.async {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color(.accent))
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
                            .foregroundColor(Color(.accent))
                    }
                }
            }
        }
        .background(Color(.light))
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
