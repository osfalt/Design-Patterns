//
//  Prototype.swift
//  DesignPatterns
//
//  Created by Dre on 23.03.17.
//  Copyright © 2017 Dre. All rights reserved.
//

/*
 Прототип (Prototype)
 
 Облегчает динамическое создание путем определения классов, объекты которых могут создавать собственные дубликаты.
 */

import Foundation

// Prototype

fileprivate protocol Animal: CustomStringConvertible {
    
    var name: String { get }
    
    func clone() -> Animal
}

// Concrete Prototype

fileprivate class Sheep: Animal {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func clone() -> Animal {
        return Sheep(name: self.name)
    }
    
    var description: String {
        return "Sheep: { name: \(self.name) }"
    }
}

// Client

class PrototypeSample {
    
    init() {
        let dolly = Sheep(name: "Dolly")
        let dollyClone = dolly.clone()
        
        print("dolly = \(dolly)")
        print("dollyClone = \(dollyClone)")
    }
}
