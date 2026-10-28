//
//  SplashView.swift
//  OnboardingPage
//
//  Created by Fatimah Aljifry on 14/05/1448 AH.
//


import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack{
            
            Color(red: 0.98, green: 0.97,blue: 0.95).ignoresSafeArea()
            Circle()
                .fill(Color(red: 0.82, green: 0.44, blue: 0.09).opacity(0.5))
                .frame(width: 130,height: 128)
                .position(x:10, y:00)
            Circle()
                .fill(Color(red: 0.82, green: 0.44, blue: 0.09).opacity(0.3))
                .frame(width: 130,height: 128)
                .position(x:300, y:400)
            Circle()
                .fill(Color(red: 0.82, green: 0.44, blue: 0.09).opacity(0.3))
                .frame(width: 130,height: 128)
                .position(x:200, y:-80)
            Circle()
                .fill(Color(red: 0.82, green: 0.44, blue: 0.09).opacity(0.6))
                .frame(width: 60,height: 60)
                .position(x:100, y:500)
            Circle()
                .fill(Color(red: 0.82, green: 0.44, blue: 0.09).opacity(0.3))
                .frame(width: 163,height: 154)
                .position(x:350, y:30)
            Circle()
                .fill(Color(red: 0.82, green: 0.44, blue: 0.09).opacity(0.3))
                .frame(width: 96,height: 93)
                .position(x:283, y:757)
            
            VStack{
                
                    Image(systemName:"hanger")
                    
                        .resizable()
                        .scaledToFit()
                        .frame(width:124,height:108)
                        .fontWeight(.thin)
                    
                    Text("Wardrobe")
                        .font(.largeTitle)
                        .fontWeight(.thin)
                    
                    Text("Discover your confidence.")
                        .font(.footnote)
                        .fontWeight(.ultraLight)
                    
                    
                   
            
                    
                
            }
        }
            }
}

#Preview {
    SplashView()
} 
