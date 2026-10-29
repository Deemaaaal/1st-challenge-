//
//  profile page.swift
//  MyApp
//
//  Created by jood on 11/05/1448 AH.
//

import SwiftUI

struct profile_page: View {
    
    @Environment(OnboardingData.self) private var data
    @State private var bust: Double = 92.0
    @State private var showBustPicker = false
    @State private var selectedBust: Double = 92.0
    @State private var bustWhole = 92
    @State private var bustDecimal = 0
    @State private var waist: Double = 72.0
    @State private var showWaistPicker = false
    @State private var selectedWaist: Double = 72.0
    @State private var waistWhole = 72
    @State private var waistDecimal = 0
    @State private var hips: Double = 92.0
    @State private var showHipsPicker = false
    @State private var selectedHips: Double = 92.0
    @State private var hipsWhole = 92
    @State private var hipsDecimal = 0
    @State private var height: Double = 160.0
    @State private var showHeightPicker = false
    @State private var selectedHeight: Double = 160.0
    @State private var heightWhole = 160
    @State private var heightDecimal = 0
    @State private var showDoesItFit = false
    // Uses the same parser as onboarding, so Arabic digits and commas are read correctly.
    private func measurementValue(_ text: String, fallback: Double) -> Double {
        data.number(from: text) ?? fallback
    }
    // Same formula as the rest of the app (BodyShape.from).
    private var bodyShape: BodyShape {
        BodyShape.from(bust: bust, waist: waist, hips: hips)
    }
    
    private func saveToData() {
        data.bust = String(bust)
        data.waist = String(waist)
        data.hips = String(hips)
        data.height = String(height)
    }
    
    var body: some View {
        
        ZStack {
            Color(
                red: 0.98,
                green:0.97,
                blue: 0.95
            )
            .ignoresSafeArea()
            BackgroundView()
            
            Circle()
                .fill(Color(
                    red: 237.0 / 255.0,
                    green: 230.0 / 255.0,
                    blue: 218.0 / 255.0
                ))
                .frame(width: 90, height: 90)
                .overlay {
                    Image(bodyShape.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                }
                .offset(y:-260)
            
            Text(bodyShape.title)
                .font(.system(size: 25, weight: .bold))
                .foregroundStyle(Color(
                    red: 43.0 / 255.0,
                    green: 40.0 / 255.0,
                    blue: 37.0 / 255.0
                ))
                .frame(width: 214, height: 30)
                .offset(y: -150)
            
            
            VStack(spacing: 0) {
                
                // Bust
                HStack {
                    Text("Bust")
                        .font(.system(size: 18))
                        .foregroundStyle(Color(
                            red: 43.0 / 255.0,
                            green: 40.0 / 255.0,
                            blue: 37.0 / 255.0
                        ))
                    
                    Spacer()
                    
                    Text(String(format: "%.1f cm", bust))
                        .font(.system(size: 18))
                        .foregroundStyle(Color(
                            red: 43.0 / 255.0,
                            green: 40.0 / 255.0,
                            blue: 37.0 / 255.0
                        ))
                    
                    
                    Button {
                        bustWhole = Int(bust)
                        bustDecimal = Int((bust * 10).rounded()) % 10
                        selectedBust = bust
                        showBustPicker = true
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundStyle(Color(
                                red: 143.0 / 255.0,
                                green: 129.0 / 255.0,
                                blue: 115.0 / 255.0
                                
                            ))
                        
                    }
                    .buttonStyle(.plain)
                    
                    .frame(width: 20)
                }
                .frame(height: 41)
                .padding(.horizontal, 14)
                
                Divider().overlay(Color.white)
                
                
                // Waist
                HStack {
                    Text("Waist")
                        .font(.system(size: 18))
                        .foregroundStyle(Color(
                            red: 43.0 / 255.0,
                            green: 40.0 / 255.0,
                            blue: 37.0 / 255.0
                        ))
                    
                    Spacer()
                    
                    Text(String(format: "%.1f cm", waist))
                        .font(.system(size: 18))
                        .foregroundStyle(Color(
                            red: 105.0 / 255.0,
                            green: 91.0 / 255.0,
                            blue: 80.0 / 255.0
                        ))
                        .frame(width: 95, alignment: .trailing)
                    
                    Button {
                        waistWhole = Int(waist)
                        waistDecimal = Int((waist * 10).rounded()) % 10
                        selectedWaist = waist
                        showWaistPicker = true
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundStyle(Color(
                                red: 143.0 / 255.0,
                                green: 129.0 / 255.0,
                                blue: 115.0 / 255.0
                            ))
                            .frame(width: 20)
                    }
                    .buttonStyle(.plain)
                }
                .frame(height: 41)
                .padding(.horizontal, 14)
                
                Divider().overlay(Color.white)
                
                // Hips
                HStack {
                    Text("Hips")
                        .font(.system(size: 18))
                        .foregroundStyle(Color(
                            red: 43.0 / 255.0,
                            green: 40.0 / 255.0,
                            blue: 37.0 / 255.0
                        ))
                    
                    Spacer()
                    
                    Text(String(format: "%.1f cm", hips))
                        .font(.system(size: 18))
                        .foregroundStyle(Color(
                            red: 105.0 / 255.0,
                            green: 91.0 / 255.0,
                            blue: 80.0 / 255.0
                        ))
                        .frame(width: 95, alignment: .trailing)
                    
                    Button {
                        hipsWhole = Int(hips)
                        hipsDecimal = Int((hips * 10).rounded()) % 10
                        selectedHips = hips
                        showHipsPicker = true
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundStyle(Color(
                                red: 143.0 / 255.0,
                                green: 129.0 / 255.0,
                                blue: 115.0 / 255.0
                            ))
                            .frame(width: 20)
                    }
                    .buttonStyle(.plain)
                }
                .frame(height: 41)
                .padding(.horizontal, 14)
                
                Divider().overlay(Color.white)
                
                // Height
                HStack {
                    Text("Height")
                        .font(.system(size: 18))
                        .foregroundStyle(Color(
                            red: 43.0 / 255.0,
                            green: 40.0 / 255.0,
                            blue: 37.0 / 255.0
                        ))
                    
                    Spacer()
                    
                    Text(String(format: "%.1f cm", height))
                        .font(.system(size: 18))
                        .foregroundStyle(Color(
                            red: 105.0 / 255.0,
                            green: 91.0 / 255.0,
                            blue: 80.0 / 255.0
                        ))
                        .frame(width: 95, alignment: .trailing)
                    
                    Button {
                        heightWhole = Int(height)
                        heightDecimal = Int((height * 10).rounded()) % 10
                        selectedHeight = height
                        showHeightPicker = true
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundStyle(Color(
                                red: 143.0 / 255.0,
                                green: 129.0 / 255.0,
                                blue: 115.0 / 255.0
                            ))
                            .frame(width: 20)
                    }
                    .buttonStyle(.plain)
                }
                .frame(height: 41)
                .padding(.horizontal, 14)
                
            }
            .frame(width: 348, height: 168)
            .background(Color(
                red: 241.0 / 255.0,
                green: 235.0 / 255.0,
                blue: 225.0 / 255.0
            ))
            .clipShape(RoundedRectangle(cornerRadius: 22))
            
            // Pinned to the bottom, in the same spot as the main button on other screens
            VStack {
                Spacer()

                Button("Does it fit?") {
                    showDoesItFit = true
                }
                .buttonStyle(PrimaryButtonStyle())
                .padding(.horizontal, 24)
                .padding(.bottom, 54)
            }
        }
        // Setting showDoesItFit to false pops Does it Fit? and the result screen together
        .navigationDestination(isPresented: $showDoesItFit) {
            DoesItFit(backToProfile: { showDoesItFit = false })
        }
        
        .sheet(isPresented: $showBustPicker) {
            NavigationStack {
                VStack {
                    HStack(spacing: 0) {
                        Picker("Bust", selection: $bustWhole) {
                            ForEach(0...300, id: \.self) { number in
                                Text("\(number)")
                                    .tag(number)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 100)
                        
                        Picker("Decimal", selection: $bustDecimal) {
                            ForEach(0...9, id: \.self) { number in
                                Text("\(number)")
                                    .tag(number)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 70)
                        
                        Text("cm")
                            .font(.system(size: 18))
                    }
                    .navigationTitle("Bust")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                bust = Double(bustWhole) + Double(bustDecimal) / 10.0
                                showBustPicker = false
                            }
                        }
                    }
                }
                .presentationDetents([.height(250)])
            }
            
            
        }
        
        .sheet(isPresented: $showWaistPicker) {
            NavigationStack {
                VStack {
                    HStack(spacing: 0) {
                        Picker("Waist", selection: $waistWhole) {
                            ForEach(0...300, id: \.self) { number in
                                Text("\(number)")
                                    .tag(number)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 100)
                        
                        Picker("Decimal", selection: $waistDecimal) {
                            ForEach(0...9, id: \.self) { number in
                                Text("\(number)")
                                    .tag(number)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 70)
                        
                        Text("cm")
                            .font(.system(size: 18))
                            .padding(.leading, 8)
                    }
                    
                    Spacer(minLength: 0)
                }
                .navigationTitle("Waist")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            waist = Double(waistWhole)
                            + Double(waistDecimal) / 10.0
                            
                            showWaistPicker = false
                        }
                    }
                }
            }
            .presentationDetents([.height(250)])
        }
        
        .sheet(isPresented: $showHipsPicker) {
            NavigationStack {
                VStack {
                    HStack(spacing: 0) {
                        Picker("Hips", selection: $hipsWhole) {
                            ForEach(0...300, id: \.self) { number in
                                Text("\(number)")
                                    .tag(number)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 100)
                        
                        Picker("Decimal", selection: $hipsDecimal) {
                            ForEach(0...9, id: \.self) { number in
                                Text("\(number)")
                                    .tag(number)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 70)
                        
                        Text("cm")
                            .font(.system(size: 18))
                            .padding(.leading, 8)
                    }
                    
                    Spacer(minLength: 0)
                }
                .navigationTitle("Hips")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            hips = Double(hipsWhole)
                            + Double(hipsDecimal) / 10.0
                            
                            showHipsPicker = false
                        }
                    }
                }
            }
            .presentationDetents([.height(250)])
        }
        
        .sheet(isPresented: $showHeightPicker) {
            NavigationStack {
                VStack {
                    HStack(spacing: 0) {
                        Picker("Height", selection: $heightWhole) {
                            ForEach(0...250, id: \.self) { number in
                                Text("\(number)")
                                    .tag(number)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 100)
                        
                        Picker("Decimal", selection: $heightDecimal) {
                            ForEach(0...9, id: \.self) { number in
                                Text("\(number)")
                                    .tag(number)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 70)
                        
                        Text("cm")
                            .font(.system(size: 18))
                            .padding(.leading, 8)
                    }
                    
                    Spacer(minLength: 0)
                }
                .navigationTitle("Height")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            height = Double(heightWhole)
                            + Double(heightDecimal) / 10.0
                            
                            showHeightPicker = false
                            
                        }
                    }
                }
            }
            .presentationDetents([.height(250)])
        }
        .onAppear {
            bust = measurementValue(data.bust, fallback: bust)
            waist = measurementValue(data.waist, fallback: waist)
            hips = measurementValue(data.hips, fallback: hips)
            height = measurementValue(data.height, fallback: height)
            
            bustWhole = Int(bust)
            bustDecimal = Int((bust * 10).rounded()) % 10
            
            waistWhole = Int(waist)
            waistDecimal = Int((waist * 10).rounded()) % 10
            
            hipsWhole = Int(hips)
            hipsDecimal = Int((hips * 10).rounded()) % 10
            
            heightWhole = Int(height)
            heightDecimal = Int((height * 10).rounded()) % 10
            
            selectedBust = bust
            selectedWaist = waist
            selectedHips = hips
            selectedHeight = height
            saveToData()
            
        }
        .onChange(of: bust)   { saveToData() }
        .onChange(of: waist)  { saveToData() }
        .onChange(of: hips)   { saveToData() }
        .onChange(of: height) { saveToData() }
        .navigationBarBackButtonHidden(true)
        
        
    }
}
#Preview {
    NavigationStack {
        profile_page()
    }
    .environment(OnboardingData())
}
