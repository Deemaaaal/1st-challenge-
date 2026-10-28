//
//  Onboarding2.swift
//  OnboardingPage
//
//  Created by Fatimah Aljifry on 14/05/1448 AH.
//
import SwiftUI

struct MeasurementsView: View {
    @Environment(OnboardingData.self) private var data
    @Environment(\.dismiss) private var dismiss
    @State private var showProfile = false
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
                    Text("Almost Done")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text("This helps us understand your proportions better")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }

                // group2: hips input field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Hips (cm)")
                        .font(.subheadline)
                        .foregroundColor(.black)

                    TextField("92", text: $data.hips)
                        .keyboardType(.decimalPad)
                        .padding(.vertical, 14)
                        .padding(.horizontal, 16)
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(data.hipsError == nil
                                        ? Color.gray.opacity(0.3)
                                        : Color(red: 0.6, green: 0.2, blue: 0.15),
                                        lineWidth: 1)
                        )

                    Text(data.hipsError ?? "Around the fullest part of your hips.")
                        .font(.caption)
                        .foregroundColor(data.hipsError == nil
                                         ? .gray
                                         : Color(red: 0.6, green: 0.2, blue: 0.15))
                        .padding(.bottom, 20)
                }

                // group3: height input field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Height (cm)")
                        .font(.subheadline)
                        .foregroundColor(.black)

                    TextField("160", text: $data.height)
                        .keyboardType(.decimalPad)
                        .padding(.vertical, 14)
                        .padding(.horizontal, 16)
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(data.heightError == nil
                                        ? Color.gray.opacity(0.3)
                                        : Color(red: 0.6, green: 0.2, blue: 0.15),
                                        lineWidth: 1)
                        )

                    Text(data.heightError ?? "Measure from head to toe using a measuring tape.")
                        .font(.caption)
                        .foregroundColor(data.heightError == nil
                                         ? .gray
                                         : Color(red: 0.6, green: 0.2, blue: 0.15))
                }

                // pushes everything up and lifts the button from the bottom
                Spacer()

                Button(action: {
                    showProfile = true
                })
                {
                    Text("See my results")
                        .font(.title3)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(data.page2Complete
                                    ? Color(red: 0.82, green: 0.45, blue: 0.12)
                                    : Color(red: 0.90, green: 0.75, blue: 0.65))
                        .cornerRadius(30)
                }
                .buttonStyle(.plain)
                .disabled(!data.page2Complete)
                .animation(.easeInOut(duration: 0.3), value: data.page2Complete)

                
                ///Delete back button
                Button {
                    dismiss()
                } label: {
                    Text("Back")
                        .font(.title3)
                        .fontWeight(.bold)
                }
                .buttonStyle(.plain)
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 44)
                .padding(.bottom, 56)
            }
            .padding(.horizontal, 16)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .navigationDestination(isPresented: $showProfile) {
            profile_page()
                .environment(data)
        }
    }
}

#Preview {
    // Pretend the first page was already filled in, so bars 1 and 2 show orange
    let data = OnboardingData()
    data.bust = "92"
    data.waist = "72"
    return NavigationStack {
        MeasurementsView()
    }
    .environment(data)
}
