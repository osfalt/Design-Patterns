//
//  TemplateMethod.swift
//  DesignPatterns
//
//  Created by Dre on 23.04.17.
//  Copyright © 2017 Dre. All rights reserved.
//

/*
 Шаблонный метод (Template Method)
 
 Шаблонный метод служит шаблоном для алгоритма.
 Определяет основу алгоритма и позволяет наследникам переопределять некоторые шаги алгоритма, не изменяя его структуру в целом.
 */

import Foundation

enum GameCode {
    case chess
    case monopoly
}

// Abstract Class

fileprivate protocol Game {
    func initializeGame()
    func playGame()
    func endGame()
    func printWinner()
    func playOneGame() // Template Method
}

fileprivate extension Game {
    
    final func playOneGame() {
        initializeGame()
        playGame()
        endGame()
        printWinner()
    }
}

// Concrete Classes

fileprivate class Chess: Game {
    
    func initializeGame() {
        print("Chess -> initializeGame()")
    }
    
    func playGame() {
        print("Chess -> playGame()")
    }
    
    func endGame() {
        print("Chess -> endGame()")
    }
    
    func printWinner() {
        print("Chess -> printWinner()")
    }
}

fileprivate class Monopoly: Game {
    
    func initializeGame() {
        print("Monopoly -> initializeGame()")
    }
    
    func playGame() {
        print("Monopoly -> playGame()")
    }
    
    func endGame() {
        print("Monopoly -> endGame()")
    }
    
    func printWinner() {
        print("Monopoly -> printWinner()")
    }
}

// Client

class TemplateMethodSample {
    
    init() {
        let gameCode = arc4random_uniform(2) == 0 ? GameCode.chess : GameCode.monopoly
        
        let game: Game
        
        switch gameCode {
        case .chess:
            game = Chess()
            break
        case .monopoly:
            game = Monopoly()
            break
        }
        
        game.playOneGame()
    }
}
