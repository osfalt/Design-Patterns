//
//  FactoryMethod.swift
//  DesignPatterns
//
//  Created by Dre on 16.03.17.
//  Copyright © 2017 Dre. All rights reserved.
//

// MARK: - Description

/*
 Фабричный метод (Factory Method также известен как Виртуальный конструктор)
 
 Определяет стандартный метод создания объекта, не связанный с вызовом конструктора (инициализатора), оставляя решение о том, какой именно объект создавать, за подклассами.
 Это позволяет использовать в коде программы не специфические классы, а манипулировать абстрактными объектами на более высоком уровне.
 */

// MARK: - Sample

import Foundation

// Products

protocol Device {
}

class IPhone: Device {
}

class IPad: Device {
}

// Creators

protocol Creator {
    func createDevice() -> Device
}

class IPhoneCreator: Creator {
    
    func createDevice() -> Device {
        return IPhone()
    }
    
}

class IPadCreator: Creator {
    
    func createDevice() -> Device {
        return IPad()
    }
    
}

// Client

class FactoryMethodSample {
    
    init() {
        let creators: [Creator] = [IPhoneCreator(), IPadCreator()]

        for creator in creators {
            let device = creator.createDevice()
            print("\(String(describing: type(of: device))) created")
        }
    }

}
