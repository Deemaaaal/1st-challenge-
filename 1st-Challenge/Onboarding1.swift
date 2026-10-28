//
//  Onboarding1.swift
//  OnboardingPage
//
//  Created by Fatimah Aljifry on 14/05/1448 AH.
//
import SwiftUI
struct measurementsView2: View {
    @Environment(OnboardingData.self) private var data

    var body: some View {
        @Bindable var data = data

        ZStack {
            // background color of the screen
            Color(red: 0.98, green: 0.97, blue: 0.95)
                .ignoresSafeArea()

            // vertical stack for layout alignment and spacing
            VStack(alignment: .leading, spacing: 10) {

                // progress bars: driven by the shared data
                ProgressBars(filled: data.filled)
                    .padding(.top, 24)
                    .padding(.bottom, 30)

                // group1: screen titles
                VStack(alignment: .leading, spacing: 50) {
                    Text("Your measurements")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text("This helps us understand your proportions better")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }

                // group2: bust input field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Bust (cm)")
                        .font(.subheadline)
                        .foregroundColor(.black)

                    TextField("92", text: $data.bust)
                        .keyboardType(.decimalPad)
                        .padding(.vertical, 14)
                        .padding(.horizontal, 16)
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(data.bustError == nil
                                        ? Color.gray.opacity(0.3)
                                        : Color(red: 0.6, green: 0.2, blue: 0.15),
                                        lineWidth: 1)
                        )

                    Text(data.bustError ?? "Around the fullest part, tape level.")
                        .font(.caption)
                        .foregroundColor(data.bustError == nil
                                         ? .gray
                                         : Color(red: 0.6, green: 0.2, blue: 0.15))
                        .padding(.bottom, 20)
                }

                // group3: waist input field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Waist (cm)")
                        .font(.subheadline)
                        .foregroundColor(.black)

                    TextField("72", text: $data.waist)
                        .keyboardType(.decimalPad)
                        .padding(.vertical, 14)
                        .padding(.horizontal, 16)
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(data.waistError == nil
                                        ? Color.gray.opacity(0.3)
                                        : Color(red: 0.6, green: 0.2, blue: 0.15),
                                        lineWidth: 1)
                        )

                    Text(data.waistError ?? "Around your natural waist, the narrowest part of your torso.")
                        .font(.caption)
                        .foregroundColor(data.waistError == nil
                                         ? .gray
                                         : Color(red: 0.6, green: 0.2, blue: 0.15))
                }

                // pushes everything up and lifts the button from the bottom
                Spacer()

                NavigationLink {
                    MeasurementsView()
                } label: {
                    Text("Next")
                        .font(.title3)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(data.page1Complete
                                    ? Color(red: 0.82, green: 0.45, blue: 0.12)
                                    : Color(red: 0.90, green: 0.75, blue: 0.65))
                        .cornerRadius(30)
                }
                .buttonStyle(.plain)
                .disabled(!data.page1Complete)
                .animation(.easeInOut(duration: 0.3), value: data.page1Complete)
                .padding(.bottom, 110)
            }
            .padding(.horizontal, 16)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

// Reusable progress bars: one bar per true/false value in the list
struct ProgressBars: View {
    var filled: [Bool]

    var body: some View {
        HStack(spacing: 15) {
            ForEach(filled.indices, id: \.self) { index in
                Capsule()
                    .fill(filled[index]
                          ? Color(red: 0.82, green: 0.45, blue: 0.12)
                          : Color(red: 0.90, green: 0.75, blue: 0.65))
                    .frame(height: 4)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: filled)
    }
}

#Preview {
    NavigationStack {
        measurementsView2()
    }
    .environment(OnboardingData())
}


 

