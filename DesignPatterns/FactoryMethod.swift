//
//  FactoryMethod.swift
//  DesignPatterns
//
//  Created by Dre on 16.03.17.
//  Copyright © 2017 Dre. All rights reserved.
//

/*
 Фабричный метод (Factory Method, Virtual Constructor)
 
 Определяет стандартный метод создания объекта, не связанный с вызовом конструктора (инициализатора), оставляя решение о том, какой именно объект создавать, за подклассами.
 Это позволяет использовать в коде программы не специфические классы, а манипулировать абстрактными объектами на более высоком уровне.
 */

import Foundation

// Products

fileprivate protocol Device {
    var name: String { get }
}

fileprivate class IPhone: Device {
    var name = "iPhone"
}

fileprivate class IPad: Device {
    var name = "iPad"
}

// Creators

fileprivate protocol Creator {
    func createDevice() -> Device
}

fileprivate class IPhoneCreator: Creator {
    
    func createDevice() -> Device {
        return IPhone()
    }
    
}

fileprivate class IPadCreator: Creator {
    
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
            print("\(device.name) created")
        }
    }

}
