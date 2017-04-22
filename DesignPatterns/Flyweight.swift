//
//  Flyweight.swift
//  DesignPatterns
//
//  Created by Dre on 11.04.17.
//  Copyright © 2017 Dre. All rights reserved.
//

/*
 Приспособленец (Flyweight)
 
 Объект, представляющий себя как уникальный экземпляр в разных местах программы, по факту не является таковым.
 Оптимизация работы с памятью путём предотвращения создания экземпляров элементов, имеющих общую сущность.
 */

import Foundation

fileprivate let randomUpperBound = UInt32.max

// Flyweight

fileprivate protocol EnglishCharacter {
    
    var hashValue: Int { get }
    
    var symbol: Character { get set }
    var width: Int { get set }
    var height: Int { get set }
    
    func printCharacter()
}

// Concrete Flyweight

fileprivate class CharacterA: EnglishCharacter {

    var hashValue: Int

    static func ==(lhs: CharacterA, rhs: CharacterA) -> Bool {
        return lhs.symbol == rhs.symbol
    }
    
    var symbol: Character
    var width: Int
    var height: Int
    
    init() {
        self.symbol = "A"
        self.width = 10
        self.height = 20
        self.hashValue = Int(arc4random_uniform(randomUpperBound))
    }
    
    func printCharacter() {
        print("symbol = \(symbol) width = \(width) height = \(height) hashValue = \(hashValue)")
    }
}

fileprivate class CharacterB: EnglishCharacter {
    
    var hashValue: Int
    
    static func ==(lhs: CharacterB, rhs: CharacterB) -> Bool {
        return lhs.symbol == rhs.symbol
    }
    
    var symbol: Character
    var width: Int
    var height: Int
    
    init() {
        self.symbol = "B"
        self.width = 20
        self.height = 30
        self.hashValue = Int(arc4random_uniform(randomUpperBound))
    }
    
    func printCharacter() {
        print("symbol = \(symbol) width = \(width) height = \(height) hashValue = \(hashValue)")
    }
}

fileprivate class CharacterC: EnglishCharacter {
    
    var hashValue: Int
    
    static func ==(lhs: CharacterC, rhs: CharacterC) -> Bool {
        return lhs.symbol == rhs.symbol
    }
    
    var symbol: Character
    var width: Int
    var height: Int
    
    init() {
        self.symbol = "C"
        self.width = 40
        self.height = 50
        self.hashValue = Int(arc4random_uniform(randomUpperBound))
    }
    
    func printCharacter() {
        print("symbol = \(symbol) width = \(width) height = \(height) hashValue = \(hashValue)")
    }
}

// Flyweight Factory

fileprivate class CharactersFactory {
    
    private var charactersDict = [Int: EnglishCharacter]()
    
    func characterBy(code: Int) -> EnglishCharacter? {
        
        if let cachedCharacter = charactersDict[code] {
            return cachedCharacter
        }
        
        var newCharacter: EnglishCharacter?
        switch code {
        case 1:
            newCharacter = CharacterA()
            break
        case 2:
            newCharacter = CharacterB()
            break
        case 3:
            newCharacter = CharacterC()
            break
        default:
            return nil
        }
        
        charactersDict[code] = newCharacter
        return newCharacter
    }
}

// Client

class FlyweightSample {
    
    init() {
        let charactersFactory = CharactersFactory()
        
        var hashValues = Set<Int>()
        
        for _ in 0..<10 {
            for code in 1...5 {
                if let character = charactersFactory.characterBy(code: code) {
                    character.printCharacter()
                    hashValues.insert(character.hashValue)
                }
            }
        }
        
        print("Unique Hash Values = \(hashValues)")
    }
}
