//
//  State.swift
//  DesignPatterns
//
//  Created by Dre on 24.04.17.
//  Copyright © 2017 Dre. All rights reserved.
//

/*
 Состояние (State, Objects for States)
 
 Используется, если во время выполнения программы объект должен менять своё поведение в зависимости от своего состояния.
 Следует использовать, чтобы заменить массивные условные операторы, огранизующие изменение поведения в зависимости от состояния.
 */

import Foundation

// State

fileprivate protocol BallState {
    func answer() -> String
}

// Concrete States

fileprivate class PositiveState: BallState {
    
    func answer() -> String {
        let random = arc4random_uniform(5)
        switch random {
        case 0:
            return "It is certain"
        case 1:
            return "It is decidedly so"
        case 2:
            return "Without a doubt"
        case 3:
            return "You may rely on it"
        default:
            return "Yes — definitely"
        }
    }
}

fileprivate class HesitantPositiveState: BallState {
    
    func answer() -> String {
        let random = arc4random_uniform(5)
        switch random {
        case 0:
            return "As I see it, yes"
        case 1:
            return "Most likely"
        case 2:
            return "Outlook good"
        case 3:
            return "Signs point to yes"
        default:
            return "Yes"
        }
    }
}

fileprivate class NeutralState: BallState {
    
    func answer() -> String {
        let random = arc4random_uniform(5)
        switch random {
        case 0:
            return "Reply hazy, try agai"
        case 1:
            return "Ask again later"
        case 2:
            return "Better not tell you now"
        case 3:
            return "Cannot predict now"
        default:
            return "Concentrate and ask again"
        }
    }
}

fileprivate class NegativeState: BallState {
    
    func answer() -> String {
        let random = arc4random_uniform(5)
        switch random {
        case 0:
            return "Don’t count on it"
        case 1:
            return "My reply is no"
        case 2:
            return "My sources say no"
        case 3:
            return "Outlook not so good"
        default:
            return "Very doubtful"
        }
    }
}

// Context

fileprivate class Magic8Ball {
    
    var state: BallState?
    
    func showAnswer(to question: String) {
        let random = arc4random_uniform(4)
        switch random {
        case 0:
            state = PositiveState()
            break
        case 1:
            state = HesitantPositiveState()
            break
        case 2:
            state = NeutralState()
            break
        default:
            state = NegativeState()
            break
        }
        
        print("Q: \(question) - A: \(state!.answer())")
    }
}

// Client

class StateSample {
    
    init() {
        let question = "iOS is best mobile operating system?"
       
        let magicBall = Magic8Ball()
        magicBall.showAnswer(to: question)
        magicBall.showAnswer(to: question)
        magicBall.showAnswer(to: question)
        magicBall.showAnswer(to: question)
    }
}
