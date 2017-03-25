//
//  Adapter.swift
//  DesignPatterns
//
//  Created by Dre on 24.03.17.
//  Copyright © 2017 Dre. All rights reserved.
//

/*
 Адаптер (Adapter)
 
 Приводит интерфейс класса (или нескольких классов) к интерфейсу требуемого вида.
 
 Реализация: 
 Включение уже существующего класса в другой класс. Интерфейс включающего класса приводится в соответствие с новыми требованиями, а вызовы его методов преобразуются в вызовы методов включённого класса.
 
 Примечание:
 - Адаптер обеспечивает отличающийся интерфейс к объекту.
 - Прокси обеспечивает тот же самый интерфейс.
 - Декоратор обеспечивает расширенный интерфейс.
 */

import Foundation

// Target

fileprivate protocol OldPurchaseSDK {
    func beginTransaction()
    func purchase(product: String)
    func commitTransaction()
}

fileprivate class OldPurchaseSDKImpl: OldPurchaseSDK {
    func beginTransaction() {
        print(">>> begin transaction")
    }
    
    func purchase(product: String) {
        print("    purchase product: '\(product)'")
    }
    
    func commitTransaction() {
        print("<<< commit transaction")
    }
}

// Adaptee

fileprivate protocol NewPurchaseSDK {
    func startTransaction()
    func buy(product: String)
    func endTransaction()
}

fileprivate class NewPurchaseSDKImpl: NewPurchaseSDK {
    func startTransaction() {
        print(">>> start transaction")
    }
    
    func buy(product: String) {
        print("    buy product: '\(product)'")
    }
    
    func endTransaction() {
        print("<<< end transaction")
    }
}

// Adapter

// MARK: - First Variant [Object Adapter] (using composition)

fileprivate class NewPurchaseSDKAdapter: OldPurchaseSDK {
    
    let newPurchaseSDK: NewPurchaseSDK
    
    init(newPurchaseSDK: NewPurchaseSDK) {
        self.newPurchaseSDK = newPurchaseSDK
    }
    
    func beginTransaction() {
        newPurchaseSDK.startTransaction()
    }
    
    func purchase(product: String) {
        newPurchaseSDK.buy(product: product)
    }
    
    func commitTransaction() {
        newPurchaseSDK.endTransaction()
    }
}

// MARK: - Second Variant [Class Adapter] (using inheritance)

fileprivate class NewPurchaseSDKAdapterV2: NewPurchaseSDKImpl, OldPurchaseSDK {
    func beginTransaction() {
        startTransaction()
    }
    
    func purchase(product: String) {
        buy(product: product)
    }
    
    func commitTransaction() {
        endTransaction()
    }
}


// MARK: - Client

class AdapterSample {
    
    init() {
        runFirstVariant()
        runSecondVariant()
    }
    
    private func runFirstVariant() {
        // Object Adapter
        print("1) First Variant [Object Adapter]")
        let oldPurchaseSDK: OldPurchaseSDK = OldPurchaseSDKImpl()
        let newPurchaseSDK: NewPurchaseSDK = NewPurchaseSDKImpl()
        let newPurchaseSDKAdapter: OldPurchaseSDK = NewPurchaseSDKAdapter(newPurchaseSDK: newPurchaseSDK)
        
        print("Old Purchase SDK:")
        purchaseCoins(purchaseSDK: oldPurchaseSDK)
        print()
        
        print("New Purchase SDK Adapter:")
        purchaseCoins(purchaseSDK: newPurchaseSDKAdapter)
        print()
    }
    
    private func runSecondVariant() {
        // Class Adapter
        print("2) Second Variant [Class Adapter]")
        let oldPurchaseSDK: OldPurchaseSDK = OldPurchaseSDKImpl()
        let newPurchaseSDKAdapter: OldPurchaseSDK = NewPurchaseSDKAdapterV2()
        
        print("Old Purchase SDK:")
        purchaseCoins(purchaseSDK: oldPurchaseSDK)
        print()
        
        print("New Purchase SDK Adapter:")
        purchaseCoins(purchaseSDK: newPurchaseSDKAdapter)
    }
    
    // immutable method
    private func purchaseCoins(purchaseSDK: OldPurchaseSDK) {
        purchaseSDK.beginTransaction()
        purchaseSDK.purchase(product: "100 coins")
        purchaseSDK.commitTransaction()
    }
}
