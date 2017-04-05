//
//  Facade.swift
//  DesignPatterns
//
//  Created by Dre on 04.04.17.
//  Copyright © 2017 Dre. All rights reserved.
//

/*
 Фасад (Facade)
 
 Продоставляет упрощенный, удобный интерфейс для группы подсистем или сложной подсистемы, оставляя доступ к полной функциональности подсистемы.
 Позволяюет скрыть сложность системы путём сведения всех возможных внешних вызовов к одному объекту, делегирующему их соответствующим объектам системы.
 */

import Foundation

// Complex Components

fileprivate class ApplePushNotificationService {
    
    func configureAPS() {
        print("Apple Push Notification Service -> Configure APNS")
    }
    
    func createPushMessage() {
        print("Apple Push Notification Service -> Creating Push Message")
    }
    
    func sendPush() {
        print("Apple Push Notification Service -> Sending Push Message")
    }
}

fileprivate class GoogleCloudMessaging {
    
    func configureGCM() {
        print("Google Cloud Messaging -> Configure GCM")
    }
    
    func createPushMessage() {
        print("Google Cloud Messaging -> Creating Push Message")
    }
    
    func sendPush() {
        print("Google Cloud Messaging -> Sending Push Message")
    }
}

fileprivate class MicrosoftPushNotificationService {
    
    func configureMPNS() {
        print("Microsoft Push Notification Service -> Configure MPNS")
    }
    
    func createPushMessage() {
        print("Microsoft Push Notification Service -> Creating Push Message")
    }
    
    func sendPush() {
        print("Microsoft Push Notification Service -> Sending Push Message")
    }
}

// Facade

class PushNotificationServiceFacade {

    private let apns = ApplePushNotificationService()
    private let gcm = GoogleCloudMessaging()
    private let mpns = MicrosoftPushNotificationService()
    
    func sendPushMessage() {
        apns.configureAPS()
        apns.createPushMessage()
        apns.sendPush()
        
        gcm.configureGCM()
        gcm.createPushMessage()
        gcm.sendPush()
        
        mpns.configureMPNS()
        mpns.createPushMessage()
        mpns.sendPush()
    }
}

// Client

class FacadeSample {
    
    init() {
        // Without Facade
        print("--- Without Facade ---")
        let apns = ApplePushNotificationService()
        let gcm = GoogleCloudMessaging()
        let mpns = MicrosoftPushNotificationService()
        
        apns.configureAPS()
        apns.createPushMessage()
        apns.sendPush()
        
        gcm.configureGCM()
        gcm.createPushMessage()
        gcm.sendPush()
        
        mpns.configureMPNS()
        mpns.createPushMessage()
        mpns.sendPush()
        
        // With Facade
        print("--- With Facade ---")
        let facade = PushNotificationServiceFacade()
        facade.sendPushMessage()
    }
}




