//
//  ContentView.swift
//  Drawing
//
//  Created by Daan Schutte on 06/11/2022.
//

import SwiftUI

//struct Triangle: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
//
//        return path
//    }
//}
//
//struct Arc: InsettableShape {
//    let startAngle: Angle
//    let endAngle: Angle
//    let clockwise: Bool
//    var insetAmount = 0.0
//
//    func path(in rect: CGRect) -> Path {
//        let rotationAdjustment = Angle.degrees(90)
//        let modifiedStart = startAngle - rotationAdjustment
//        let modifiedEnd = endAngle - rotationAdjustment
//
//        var path = Path()
//
//        path.addArc(center: CGPoint(x: rect.midX, y: rect.minY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
//
//        return path
//    }
//
//    func inset(by amount: CGFloat) -> some InsettableShape {
//        var arc = self
//        arc.insetAmount += amount
//        return arc
//    }
//}


//struct Flower: Shape {
//    var petalOffset = -20.0
//    var petalWidth = 100.0
//
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
//            let rotation = CGAffineTransform(rotationAngle: number)
//            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
//
//            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))
//            let rotatedPetal = originalPetal.applying(position)
//
//            path.addPath(rotatedPetal)
//        }
//
//        return path
//    }
//}


struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5),
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup() // uses metal for off screen GPU rendering 
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    //    @State private var petalOffset = -20.0
    //    @State private var petalWidth = 100.0
    
    
    @State private var colorCycle = 0.0
    
    var body: some View {
        //        Triangle()
        //            .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
        //            .frame(width: 300, height: 300)
        
        //        Arc(startAngle: .degrees(0), endAngle: .degrees(135), clockWise: true)
        //            .stroke(.blue, lineWidth: 10)
        //            .frame(width: 300, height: 300)
        
        //        Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
        //            .strokeBorder(.blue, lineWidth: 40)
        //            .frame(height: 100)
        
        
        //        VStack {
        //            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
        //                .stroke(.red, lineWidth: 1)
        //
        //            Text("Offset")
        //            Slider(value: $petalOffset, in: -40...40)
        //                .padding([.horizontal,.bottom])
        //
        //            Text("Width")
        //            Slider(value: $petalWidth, in: 0...100)
        //                .padding(.horizontal)
        //
        //        }
        
        
        VStack {
            ColorCyclingCircle(amount: colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
