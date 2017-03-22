//
//  AbstractFactory.swift
//  DesignPatterns
//
//  Created by Dre on 17.03.17.
//  Copyright © 2017 Dre. All rights reserved.
//

/*
 Абстрактная фабрика (Abstract Factory, Kit, Toolkit)
 
 Предоставляет интерфейс для создания семейств взаимосвязанных или взаимозависимых объектов, не специфицируя их конкретных классов.
 
 Плюсы:
 + изолирует конкретные классы;
 + упрощает замену семейств продуктов;
 + гарантирует сочетаемость продуктов.
 
 Минусы:
 - сложно добавить поддержку нового вида продуктов.
 */

import Foundation

// Abstract products

fileprivate protocol Smartphone {
    func makeCall()
}

fileprivate protocol Tablet {
    func makeFun()
}

fileprivate protocol Laptop {
    func makeJob()
}

// Concrete products

fileprivate class IPhone: Smartphone {
    func makeCall() {
        print("iPhone calls to a friend")
    }
}

fileprivate class IPad: Tablet {
    func makeFun() {
        print("iPad runs a game")
    }
}

fileprivate class Macbook: Laptop {
    func makeJob() {
        print("Macbook doesn't make you a iOS Developer :)")
    }
}

fileprivate class Pixel: Smartphone {
    func makeCall() {
        print("Pixel calls to a friend")
    }
}

fileprivate class PixelC: Tablet {
    func makeFun() {
        print("Pixel C runs a game")
    }
}

fileprivate class Chromebook: Laptop {
    func makeJob() {
        print("Chromebook will make you unemployed :)")
    }
}

// Abstract Factory

fileprivate protocol AbstractFactory {
    func createSmartphone() -> Smartphone
    func createTablet() -> Tablet
    func createLaptop() -> Laptop
}

// Concrete Factories

fileprivate class AppleFactory: AbstractFactory {
    
    func createSmartphone() -> Smartphone {
        return IPhone()
    }

    func createTablet() -> Tablet {
        return IPad()
    }
    
    func createLaptop() -> Laptop {
        return Macbook()
    }
    
}

fileprivate class GoogleFactory: AbstractFactory {
    
    func createSmartphone() -> Smartphone {
        return Pixel()
    }
    
    func createTablet() -> Tablet {
        return PixelC()
    }
    
    func createLaptop() -> Laptop {
        return Chromebook()
    }
    
}

// Client

class AbstractFactorySample {
    
    private enum Manufacturer {
        case apple
        case google
    }
    
    init() {
        var factory: AbstractFactory
        
        switch randomManufacturer() {
        case .apple:
            factory = AppleFactory()
        case .google:
            factory = GoogleFactory()
        }
        
        let smartphone = factory.createSmartphone()
        let tablet = factory.createTablet()
        let laptop = factory.createLaptop()
        
        smartphone.makeCall()
        tablet.makeFun()
        laptop.makeJob()
    }
    
    private func randomManufacturer() -> Manufacturer {
        return arc4random_uniform(2) == 0 ? .apple : .google
    }
    
}
