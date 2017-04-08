//
//  Bridge.swift
//  DesignPatterns
//
//  Created by Dre on 07.04.17.
//  Copyright © 2017 Dre. All rights reserved.
//

/*
 Мост (Bridge, Handle/Body)
 
 Разделяет абстракцию и реализацию так, чтобы они могли изменяться независимо. 
 Другими словами, при реализации через шаблон мост, изменение структуры интерфейса не мешает изменению структуры реализации.
 */

import Foundation

// Implementor

fileprivate protocol DrawingAPI {
    func drawCircle(x: CGFloat, y: CGFloat, radius: CGFloat)
    func drawRectangle(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat)
}

// Concrete Implementor

fileprivate class OpenGL: DrawingAPI {
    
    func drawCircle(x: CGFloat, y: CGFloat, radius: CGFloat) {
        print("OpenGL -> Circle(x: \(x), y: \(y), radius: \(radius))")
    }
    
    func drawRectangle(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        print("OpenGL -> Rectangle(x: \(x), y: \(y), width: \(width), height: \(height))")
    }
}

fileprivate class DirectX: DrawingAPI {
    
    func drawCircle(x: CGFloat, y: CGFloat, radius: CGFloat) {
        print("DirectX -> Circle(x: \(x), y: \(y), radius: \(radius))")
    }
    
    func drawRectangle(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        print("DirectX -> Rectangle(x: \(x), y: \(y), width: \(width), height: \(height))")
    }
}

// Abstraction

fileprivate protocol Shape {

    var drawingAPI: DrawingAPI { get set }
    
    func draw() // low-level
    func scale(_ scaleFactor: CGFloat) // high-level
}

// Refined Abstraction

fileprivate class Circle: Shape {
    
    var x: CGFloat
    var y: CGFloat
    var radius: CGFloat
    var drawingAPI: DrawingAPI
    
    init(x: CGFloat, y: CGFloat, radius: CGFloat, drawingAPI: DrawingAPI) {
        self.x = x
        self.y = y
        self.radius = radius
        self.drawingAPI = drawingAPI
    }
    
    func draw() {
        drawingAPI.drawCircle(x: x, y: y, radius: radius)
    }

    func scale(_ scaleFactor: CGFloat) {
        radius *= scaleFactor
    }
}

fileprivate class Rectangle: Shape {
    
    var x: CGFloat
    var y: CGFloat
    var width: CGFloat
    var height: CGFloat
    var drawingAPI: DrawingAPI
    
    public init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, drawingAPI: DrawingAPI) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.drawingAPI = drawingAPI
    }
    
    func draw() {
        drawingAPI.drawRectangle(x: x, y: y, width: width, height: height)
    }
    
    func scale(_ scaleFactor: CGFloat) {
        width *= scaleFactor
        height *= scaleFactor
    }
}

// Client

class BridgeSample {
    
    init() {
        let shapes: [Shape] = [Circle(x: 30, y: 30, radius: 10, drawingAPI: OpenGL()),
                               Circle(x: 100, y: 100, radius: 25, drawingAPI: DirectX()),
                               Rectangle(x: 0, y: 0, width: 40, height: 40, drawingAPI: OpenGL()),
                               Rectangle(x: 20, y: 20, width: 50, height: 50, drawingAPI: DirectX())]
        
        for shape in shapes {
            shape.scale(2.0)
            shape.draw()
        }
    }
}
