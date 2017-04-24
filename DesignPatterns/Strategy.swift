//
//  Strategy.swift
//  DesignPatterns
//
//  Created by Dre on 24.04.17.
//  Copyright © 2017 Dre. All rights reserved.
//

/*
 Стратегия (Strategy, Policy)
 
 Определяет семейство алгоритмов, инкасулирует каждый из них и обеспечивает их взаимозаменяемость. 
 Он позволяет модифицировать алгоритмы независимо от их использования на стороне клиента.
 
 Связанные алгоримы инкапсулируются в классах, реализующих общий интерфейс. 
 Это позволяет выбирать алгоритм путем определения соответствующего класса.
 Со временем позволяет изменять выбор алгоритма.
 
 + Шаблон Strategy определяет семейство алгоритмов.
 + Это позволяет отказаться от использования переключателей и/или условных операторов.
 + Вызов всех алгоритмов должен осуществляться стандартным образом (все они должны иметь одинаковый интерфейс).
 */

import Foundation

// Strategy

fileprivate protocol OperationSystem {
    func videoCall(username: String)
    func open(url: String)
}

// Concrete Strategies

fileprivate class MacOS: OperationSystem {
    
    func videoCall(username: String) {
        print("Video call \(username) via FaceTime")
    }
    
    func open(url: String) {
        print("Open \(url) in Safari")
    }
}

fileprivate class Windows: OperationSystem {
    
    func videoCall(username: String) {
        print("Video call \(username) via Skype")
    }
    
    func open(url: String) {
        print("Open \(url) in Internet Explorer")
    }
}

// Context

fileprivate class MacBook {
    
    var os: OperationSystem?
    
    func videoCall(friend: String) {
        if let os = self.os {
            os.videoCall(username: friend)
        }
    }
    
    func openSite(_ url: String) {
        if let os = self.os {
            os.open(url: url)
        }
    }
}

// Client

class StrategySample {
    
    init() {
        let macBook = MacBook()
       
        print("--- Strategy: macOS ---")
        macBook.os = MacOS()
        macBook.videoCall(friend: "Alex")
        macBook.openSite("google.com")
       
        print("--- Strategy: Windows ---")
        macBook.os = Windows()
        macBook.videoCall(friend: "Alex")
        macBook.openSite("google.com")
    }
}
