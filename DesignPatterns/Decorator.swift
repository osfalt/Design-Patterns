//
//  Decorator.swift
//  DesignPatterns
//
//  Created by Dre on 25.03.17.
//  Copyright © 2017 Dre. All rights reserved.
//

/*
 Декоратор (Decorator, Wrapper)
 
 Предназначен для динамического подключения дополнительного поведения к объекту. Предоставляет гибкую альтернативу практике создания подклассов с целью расширения функциональности.
 
 Примечание:
 - Адаптер обеспечивает отличающийся интерфейс к объекту.
 - Прокси обеспечивает тот же самый интерфейс.
 - Декоратор обеспечивает расширенный интерфейс.
 */

import Foundation

// Component

fileprivate protocol ApiManager {
    func performRequest()
}

// Concrete Component

fileprivate class SimpleApiManager: ApiManager {
    func performRequest() {
        print("performRequest()")
    }
}

// Decorator

fileprivate protocol ExtendedApiManager: ApiManager {
    
    var apiManager: ApiManager { get }
    
    init(apiManager: ApiManager)
}

// Concrete Decorators

fileprivate class AnalyticsApiManager: ExtendedApiManager {
    
    var apiManager: ApiManager
    
    required init(apiManager: ApiManager) {
        self.apiManager = apiManager
    }
    
    func performRequest() {
        apiManager.performRequest()
        sendAnalytics()
    }
    
    func sendAnalytics() {
        print("sendAnalytics()")
    }
}

fileprivate class LoggerApiManager: ExtendedApiManager {
    
    var apiManager: ApiManager
    
    required init(apiManager: ApiManager) {
        self.apiManager = apiManager
    }
    
    func performRequest() {
        startLogging()
        apiManager.performRequest()
        endLogging()
    }
    
    func startLogging() {
        print("---> Start Logging")
    }
    
    func endLogging() {
        print("<--- End Logging")
    }
}

// Client

class DecoratorSample {
    
    init() {
        let apiManager: ApiManager = SimpleApiManager()
        let extendedApiManager: ExtendedApiManager = AnalyticsApiManager(apiManager: apiManager)
        
        print("SimpleApiManager (Component):")
        apiManager.performRequest()
        print()
        
        print("AnalyticsApiManager (Decorator):")
        extendedApiManager.performRequest()
        print()
        
        print("LoggerApiManager (Decorator):")
        LoggerApiManager(apiManager: extendedApiManager).performRequest()
    }
}

