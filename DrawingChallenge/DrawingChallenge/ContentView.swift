//
//  ContentView.swift
//  DrawingChallenge
//
//  Created by Daniel Camarena on 7/19/23.
//

import SwiftUI

struct Arrow: InsettableShape {
    var insetAmount = 0.0
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y:rect.minY))
        path.addLine(to: CGPoint(x:rect.minX, y:rect.maxY/2))
        path.addLine(to: CGPoint(x:rect.maxX, y: rect.maxY/2))
        path.addLine(to: CGPoint(x:rect.midX, y:rect.minY))
        path.move(to: CGPoint(x:rect.midX, y:rect.maxY/2))
        path.addLine(to: CGPoint(x:rect.midX, y:rect.maxY))
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arrow = self
        arrow.insetAmount += amount
        return arrow
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) {
                value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        if targetHue > 1 {
            targetHue -= 1
        }
        return Color(hue:targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var lineWidth = 2.0
    @State private var colorCycle = 0.0
    var body: some View {
        VStack {
            
            Arrow()
                .stroke(.red, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .frame(width:300, height:200)
            
            Text("Line Width")
            Slider(value: $lineWidth, in:1...100)
                .padding()
             
            
            
            // Coloring Rectangle
            ColorCyclingRectangle(amount: colorCycle)
                .frame(width: 300, height: 200)
            
            Slider(value: $colorCycle)
                .padding(.horizontal)
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
