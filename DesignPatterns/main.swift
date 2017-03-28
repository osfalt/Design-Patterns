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
    let _ = FactoryMethodSample()
    print()
    
    print("-------------------- Abstract Factory --------------------")
    let _ = AbstractFactorySample()
    print()
    
    print("-------------------- Singleton --------------------")
    let _ = SingletonSample()
    print()
    
    print("-------------------- Builder --------------------")
    let _ = BuilderSample()
    print()
    
    print("-------------------- Prototype --------------------")
    let _ = PrototypeSample()
    print()
}

// MARK: - Structural Patterns

func runStructuralPatterns() {
    print("========================= STRUCTURAL PATTERNS =========================")
    
    print("-------------------- Adapter --------------------")
    let _ = AdapterSample()
    print()
    
    print("-------------------- Decorator --------------------")
    let _ = DecoratorSample()
    print()
    
    print("-------------------- Proxy --------------------")
    let _ = ProxySample()
    print()
}

// MARK: - Run Samples

runCreationalPatterns()
runStructuralPatterns()

