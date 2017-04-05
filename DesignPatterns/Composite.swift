//
//  Composite.swift
//  DesignPatterns
//
//  Created by Dre on 05.04.17.
//  Copyright © 2017 Dre. All rights reserved.
//

/*
 Компоновщик (Composite)
 
 Объединяет объекты в древовидную структуру для представления иерархии от частного к целому. Компоновщик позволяет клиентам обращаться к отдельным объектам и к группам объектов одинаково.
 */

import Foundation

// Component

fileprivate protocol View: AnyObject {
    func draw()
}

// Leaf

fileprivate class Label: View {
    
    func draw() {
        print("Label -> draw()")
    }
}

fileprivate class Button: View {
    
    func draw() {
        print("Button -> draw()")
    }
}

fileprivate class TextView: View {
    
    func draw() {
        print("TextView -> draw()")
    }
}

// Composite

fileprivate class ContainerView: View {
    
    private var subviews: [View] = []
    
    func draw() {
        for view in subviews {
            view.draw()
        }
    }

    func add(view: View) {
        subviews.append(view)
    }
    
    func remove(view: View) {
        if let index = subviews.index(where: { $0 === view }) {
            subviews.remove(at: index)
        }
    }
    
    func getChild(_ index: Int) -> View {
        return subviews[index]
    }
}

// Client

class CompositeSample {
    
    init() {
        let innerContainer = ContainerView()
        innerContainer.add(view: Label())
        innerContainer.add(view: Button())
        innerContainer.add(view: TextView())
        
        let rootContainer = ContainerView()
        rootContainer.add(view: Label())
        rootContainer.add(view: Button())
        rootContainer.add(view: innerContainer)
        
        rootContainer.draw()
    }
    
}
