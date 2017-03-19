//
//  Singleton.swift
//  DesignPatterns
//
//  Created by Dre on 18.03.17.
//  Copyright © 2017 Dre. All rights reserved.
//

/*
 Одиночка (Singleton)
 
 Гарантирует, что в однопроцессном приложении будет единственный экземпляр некоторого класса, и предоставляет глобальную точку доступа к этому экземпляру.
 */

import Foundation

// Thread-safe

fileprivate class SingletonThreadSafe {
    
    static let shared = SingletonThreadSafe()
    
    private init() {
        print("Singleton (Thread-safe): I'm lonely :(")
    }
    
}

// Not thread-safe

fileprivate class SingletonNotThreadSafe {
    
    private static var instance: SingletonNotThreadSafe?
    
    private init() {
        print("Singleton (Not thread-safe): I'm lonely in every thread:(")
    }
    
    static func shared() -> SingletonNotThreadSafe {
        if instance == nil {
            instance = SingletonNotThreadSafe()
        }
        return instance!
    }
    
}

// Client

class SingletonSample {
    
    init() {
        for _ in 0..<5 {
            DispatchQueue.global().async {
                let _ = SingletonThreadSafe.shared
                let _ = SingletonNotThreadSafe.shared()
            }
        }

        CFRunLoopRun()
    }
    
}
