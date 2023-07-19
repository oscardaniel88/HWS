//
//  ContentView.swift
//  Drawing
//
//  Created by Daniel Camarena on 7/18/23.
//

import SwiftUI

struct Flower: Shape {
    var petalOffset: Double = -20
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8){
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            let originPetal = Path(ellipseIn: CGRect(x: petalOffset, y:0, width: petalWidth, height: rect.width / 2))
            let rotatedPetal = originPetal.applying(position)
            path.addPath(rotatedPetal)
        }
        return path
    }
}

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) {
                value in
                Circle()
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

struct Trapezoid: Shape {
    var insetAmount: Double
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path ()
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x:rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        return path
    }
}

struct Checkerboard: Shape {
    var rows: Int
    var columns: Int
    var animatableData: AnimatablePair<Double, Double>{
        get {
            AnimatablePair(Double(rows), Double(columns))
        }
        set {
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)
        
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2){
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        return path
    }
}



struct ContentView: View {
    @State private var petalOffset = -0.20
    @State private var petalWidth = 100.0
    @State private var colorCycle = 0.0
    @State private var amount = 0.0
    @State private var insetAmount = 50.0
    @State private var rows = 4
    @State private var columns = 4
    
    
    var body: some View {
        /*
         
        // Flower with petals
        VStack {
            /*
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                .fill(.red, style:FillStyle(eoFill:true))
            
            Text("Offset")
            Slider(value: $petalOffset, in:-40...40)
                .padding([.horizontal, .bottom])
            
            Text("Width")
            Slider(value: $petalWidth, in:0...100)
                .padding(.horizontal)
             */
            
            /*
            // Coloring Circle
            ColorCyclingCircle(amount: colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
                .padding(.horizontal)
             */
            
            
            
        }
        // Color blending
        VStack {
            ZStack {
                Circle()
                    .fill(Color(red: 1, green: 0, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(Color(red: 0, green: 1, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(Color(red: 0, green: 0, blue: 1))
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
            }
            .frame(width: 300, height: 300)
            
            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
        
         // Image with blur
        VStack{
            Image("Example")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .saturation(amount)
                .blur(radius:(1 - amount) * 20)
            
            Slider(value: $amount)
                .padding()
            
        }
        
        Trapezoid(insetAmount: insetAmount)
            .frame(width: 200, height: 100)
            .onTapGesture {
                withAnimation {
                    insetAmount = Double.random(in: 10...90)
                }
            }
         
         */
        
        Checkerboard(rows: rows, columns: columns)
            .onTapGesture {
                withAnimation(.linear(duration: 3)){
                    rows = 8
                    columns = 16
                }
            }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
