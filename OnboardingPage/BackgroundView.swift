//
//  BackgroundView.swift
//  profile page
//
//  Created by jood on 14/05/1448 AH.
//
import SwiftUI
// One decorative icon: pick a symbol, size, tilt, and position
struct BackgroundIcon: View {

var symbol: String
var size: CGFloat = 28
var rotation: Double = 0
var x: CGFloat
var y: CGFloat
var color: Color = Color(red: 0.87, green: 0.72, blue: 0.50)
var body: some View {
    
Image(systemName: symbol)
.font(.system(size: size, weight: .light))
.foregroundStyle(color)
.rotationEffect(.degrees(rotation))
.offset(x: x, y: y)
}
}
// Your own hourglass image, faded, used as a decoration
struct BackgroundHourglass: View {
var width: CGFloat = 60
var rotation: Double = 0
var opacity: Double = 0.35
var x: CGFloat
var y: CGFloat
var body: some View {
Image("hourglass1")
.resizable()
.scaledToFit()
.frame(width: width)
.opacity(opacity)
.rotationEffect(.degrees(rotation))
.offset(x: x, y: y)
}
}
// All the decorations together
struct BackgroundView: View {
var body: some View {
ZStack {
// Hangers
BackgroundIcon(symbol: "hanger", size: 44, rotation: 15, x: -160, y: -338,
color: Color(red: 0.65, green: 0.63, blue: 0.60))
BackgroundIcon(symbol: "hanger", size: 44, rotation: -15, x: -58, y: 166)
// Rulers
BackgroundIcon(symbol: "ruler", size: 26, rotation: -10, x: -165, y: -263)
BackgroundIcon(symbol: "ruler", size: 26, rotation: -15, x: 158, y: 107)
// Paperclips
BackgroundIcon(symbol: "paperclip", size: 28, rotation: 40, x: 95, y: -250)
//BackgroundIcon(symbol: "paperclip", size: 28, rotation: 40, x: 43, y: -166)
BackgroundIcon(symbol: "paperclip", size: 28, rotation: 40, x: -118, y: 138)
BackgroundIcon(symbol: "paperclip", size: 28, rotation: 40, x: -88, y: 369)
// Scissors (stands in for the needle)
BackgroundIcon(symbol: "scissors", size: 26, rotation: 20, x: 50, y: 338)
// Faded hourglass shapes
BackgroundHourglass(width: 55, rotation: -20, x: -130, y: -188)
BackgroundHourglass(width: 60, rotation: 25, x: 105, y: -145)
BackgroundHourglass(width: 45, rotation: 0, opacity: 0.25, x: 104, y: 157)
BackgroundHourglass(width: 55, rotation: -25, x: -178, y: 293)
BackgroundHourglass(width: 55, rotation: 10, x: 171, y: 383)
}
.allowsHitTesting(false)
}
}
#Preview {
BackgroundView()
    
}
