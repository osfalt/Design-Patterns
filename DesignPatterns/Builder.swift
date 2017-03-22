//
//  Builder.swift
//  DesignPatterns
//
//  Created by Dre on 19.03.17.
//  Copyright © 2017 Dre. All rights reserved.
//

/*
 Строитель (Builder)
 
 Позволяет объекту клиента создавать сложный объект, задавая для него только тип и содержимое. Клиент избавлен от информации о деталях построения объекта.
 
 Плюсы:
 + позволяет изменять внутреннее представление продукта;
 + изолирует код, реализующий конструирование и представление;
 + дает более тонкий контроль над процессом конструирования.
 */

import Foundation

// MARK: - First Variant (classic)

// Product

fileprivate class Smartphone: NSObject {
    
    var name: String?
    var os: String?
    var ram: String?
    var storage: String?

    override var description: String {
        let name = self.name ?? "unknown"
        let os = self.os ?? "unknown"
        let ram = self.ram ?? "unknown"
        let storage = self.storage ?? "unknown"
        
        return "Smartphone: { name: \(name), " + "os: \(os), " + "ram: \(ram), " + "storage: \(storage) }"
    }
}

// Abstract Builder

fileprivate protocol SmartphoneBuilder {
    
    var smartphone: Smartphone { get }
    
    func buildName()
    func buildOS()
    func buildRAM()
    func buildStorage()
}

// Concrete Builders

fileprivate class ExpensiveSmartphoneBuilder: SmartphoneBuilder {

    private let _smartphone = Smartphone()
    
    var smartphone: Smartphone {
        return _smartphone
    }

    func buildName() {
        smartphone.name = "Apple iPhone 7"
    }
    
    func buildOS() {
        smartphone.os = "iOS"
    }
    
    func buildRAM() {
        smartphone.ram = "2 GB"
    }
    
    func buildStorage() {
        smartphone.storage = "256 GB"
    }
}

fileprivate class CheapSmartphoneBuilder: SmartphoneBuilder {

    private let _smartphone = Smartphone()
    
    var smartphone: Smartphone {
        return _smartphone
    }
    
    func buildName() {
        smartphone.name = "Alcatel"
    }
    
    func buildOS() {
        smartphone.os = "Android"
    }
    
    func buildRAM() {
        smartphone.ram = "512 MB"
    }
    
    func buildStorage() {
        smartphone.storage = "4 GB"
    }
}

// Director

fileprivate class Director {
    
    var builder: SmartphoneBuilder!
    
    init(builder: SmartphoneBuilder) {
        self.builder = builder
    }
    
    func build() -> Smartphone {
        self.builder.buildName()
        self.builder.buildOS()
        self.builder.buildRAM()
        self.builder.buildStorage()
        return self.builder.smartphone
    }
}


// MARK: - Second Variant (using closures)

// Abstract Builder

fileprivate class SmartphoneBuilderV2 {
    
    var name: String?
    var os: String?
    var ram: String?
    var storage: String?
    
    init(build: (SmartphoneBuilderV2) -> ()) {
        build(self)
    }
}

// Concrete Builders

fileprivate class BuilderHelper {
    
    enum BuilderType {
        case cheap
        case expensive
    }
    
    static func builder(of type: BuilderType) -> SmartphoneBuilderV2 {
        switch type {
        case .expensive:
            return SmartphoneBuilderV2 { builder in
                builder.name = "Apple iPhone 7"
                builder.os = "iOS"
                builder.ram = "2 GB"
                builder.storage = "256 GB"
            }
        case .cheap:
            return SmartphoneBuilderV2 { builder in
                builder.name = "Alcatel"
                builder.os = "Android"
                builder.ram = "512 MB"
                builder.storage = "4 GB"
            }
        }
    }
}

// Director

fileprivate class DirectorV2 {
    
    var builder: SmartphoneBuilderV2!
    
    init(builder: SmartphoneBuilderV2) {
        self.builder = builder
    }
    
    func build() -> Smartphone {
        let smartphone = Smartphone()
        smartphone.name = builder.name
        smartphone.os = builder.os
        smartphone.ram = builder.ram
        smartphone.storage = builder.storage
        return smartphone
    }
}


// MARK: - Client

class BuilderSample {
    
    init() {
        runFirstVariant()
        runSecondVariant()
    }
    
    private func runFirstVariant() {
        print("1) First Variant (classic):")
        
        let director = Director(builder: ExpensiveSmartphoneBuilder())
        let expensiveSmartphone = director.build()
        print("expensiveSmartphone = \(expensiveSmartphone)")
        
        director.builder = CheapSmartphoneBuilder()
        let cheapSmartphone = director.build()
        print("cheapSmartphone = \(cheapSmartphone)")
    }
    
    private func runSecondVariant() {
        print("2) Second Variant (using closures):")
        
        let director = DirectorV2(builder: BuilderHelper.builder(of: .expensive))
        let expensiveSmartphone = director.build()
        print("expensiveSmartphone = \(expensiveSmartphone)")
        
        director.builder = BuilderHelper.builder(of: .cheap)
        let cheapSmartphone = director.build()
        print("cheapSmartphone = \(cheapSmartphone)")
    }
}
