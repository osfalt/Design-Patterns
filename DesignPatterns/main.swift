//
//  main.swift
//  DesignPatterns
//
//  Created by Dre on 16.03.17.
//  Copyright © 2017 Dre. All rights reserved.
//

import Foundation

// MARK: - Creational Patterns

func runCreationalPatterns() {
    print("========================= CREATIONAL PATTERNS =========================")
    
    print("-------------------- Factory Method --------------------")
    _ = FactoryMethodSample()
    print()
    
    print("-------------------- Abstract Factory --------------------")
    _ = AbstractFactorySample()
    print()
    
    print("-------------------- Singleton --------------------")
    _ = SingletonSample()
    print()
    
    print("-------------------- Builder --------------------")
    _ = BuilderSample()
    print()
    
    print("-------------------- Prototype --------------------")
    _ = PrototypeSample()
    print()
}

// MARK: - Structural Patterns

func runStructuralPatterns() {
    print("========================= STRUCTURAL PATTERNS =========================")
    
    print("-------------------- Adapter --------------------")
    _ = AdapterSample()
    print()
    
    print("-------------------- Decorator --------------------")
    _ = DecoratorSample()
    print()
    
    print("-------------------- Proxy --------------------")
    _ = ProxySample()
    print()

    print("-------------------- Facade --------------------")
    _ = FacadeSample()
    print()
    
    print("-------------------- Composite --------------------")
    _ = CompositeSample()
    print()
    
    print("-------------------- Bridge --------------------")
    _ = BridgeSample()
    print()
    
    print("-------------------- Flyweight --------------------")
    _ = FlyweightSample()
    print()
}

// MARK: - Behavioral Patterns

func runBehavioralPatterns() {
    print("========================= BEHAVIORAL PATTERNS =========================")
    
    print("-------------------- Observer --------------------")
    _ = ObserverSample()
    print()
    
    print("-------------------- Template Method --------------------")
    _ = TemplateMethodSample()
    print()
    
    print("-------------------- Strategy --------------------")
    _ = StrategySample()
    print()
    
    print("-------------------- State --------------------")
    _ = StateSample()
    print()
}

// MARK: - Run Samples

runCreationalPatterns()
runStructuralPatterns()
runBehavioralPatterns()

