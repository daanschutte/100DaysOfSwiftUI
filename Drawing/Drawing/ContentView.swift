//
//  ContentView.swift
//  Drawing
//
//  Created by Daan Schutte on 06/11/2022.
//

import SwiftUI

//struct Trapezoid: Shape {
//    var insetAmount: Double
//
//    var animatableData: Double {
//        get { insetAmount }
//        set { insetAmount = newValue }
//    }
//
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//        path.move(to: CGPoint(x: 0, y: rect.maxY))
//        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
//
//        return path
//    }
//}


//struct Checkerboard: Shape {
//    var rows: Int
//    var columns: Int
//
//    var animatableData: AnimatablePair<Double, Double> {
//        get {
//            AnimatableData(Double(rows), Double(columns))
//        }
//        set {
//            rows = Int(newValue.first)
//            columns = Int(newValue.second)
//        }
//    }
//
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//        let rowSize = rect.height / Double(rows)
//        let columnSize = rect.width / Double(columns)
//
//        for row in 0..<rows {
//            for column in 0..<columns {
//                if (row + column).isMultiple(of: 2) {
//                    let startX = columnSize * Double(column)
//                    let startY = rowSize * Double(row)
//
//                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
//                    path.addRect(rect)
//                }
//            }
//        }
//        return path
//    }
//}


struct Arrow: Shape {
    
    var size: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // arrowhead
        let originX = rect.width / 2
        let originY = rect.height / 2
        
        path.move(to: CGPoint(x: originX - size , y: originY))
        path.addLine(to: CGPoint(x: originX, y: originY - 2 * size))
        path.addLine(to: CGPoint(x: originX + size, y: originY))
        path.addLine(to: CGPoint(x: originX - size , y: originY))
        
        // shaft
        let shaftOriginX = originX - size / 2

        path.move(to: CGPoint(x: shaftOriginX, y: originY))
        path.addLine(to: CGPoint(x: shaftOriginX, y: originY + size * 2))
        path.addLine(to: CGPoint(x: shaftOriginX + size, y: originY + size * 2))
        path.addLine(to: CGPoint(x: shaftOriginX + size, y: originY))
        
        return path
    }
}

struct ContentView: View {
    //    @State private var insetAmount = 50.0
    //
    //    var body: some View {
    //        Trapezoid(insetAmount: insetAmount)
    //            .frame(width: 200, height: 200)
    //            .onTapGesture {
    //                withAnimation {
    //                    insetAmount = Double.random(in: 10...90)
    //                } 
    //            }
    //    }
    
    
//    @State private var rows = 4
//    @State private var columns = 4
//
//    var body: some View {
//        Checkerboard(rows: rows, columns: columns)
//            .onTapGesture {
//                withAnimation(.linear(duration: 3)) {
//                    rows = 8
//                    columns = 16
//                }
//            }
//    }
    
    @State private var size = 50.0
    @State private var lineWidth = 1.0
    
    var body: some View {
        VStack{
            Arrow(size: size)
                .stroke(.blue, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .onTapGesture {
                    withAnimation(.linear(duration: 2)) {
                        if lineWidth == 1 {
                            lineWidth = 15
                        } else {
                            lineWidth = 1
                        }
                    }
                }
            
            Text("Size: \(size, format: .number.precision(.significantDigits(2)))")
            Slider(value: $size, in: 1...100)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
