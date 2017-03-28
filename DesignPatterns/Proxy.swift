//
//  Proxy.swift
//  DesignPatterns
//
//  Created by Dre on 29.03.17.
//  Copyright © 2017 Dre. All rights reserved.
//

/*
 Заместитель (Proxy, Surrogate)
 
 Представление другого объекта, обусловленное необходимостью доступа или повышения скорости, либо соображениями безопасности.
 
 Виды:
 - Виртуальный заместитель - если инстанциирование объекта требует больших затрат, а объект может не по­требоваться, то имеет смысл отложить его инстанциирование до тех пор, пока не станет действительно ясно, что объект нужен.
 
 - Удалённый заместитель - обеспечивает связь с «Субъектом», который находится в другом адресном пространстве или на удалённой машине. Также может отвечать за кодирование запроса и его аргументов и отправку закодированного запроса реальному «Субъекту»,
 
 - Защищающий заместитель - может проверять, имеет ли вызывающий объект необходимые для выполнения запроса права
 
 Примечание:
 - Адаптер обеспечивает отличающийся интерфейс к объекту.
 - Прокси обеспечивает тот же самый интерфейс.
 - Декоратор обеспечивает расширенный интерфейс.
 */

import Foundation

// Subject

fileprivate protocol Image {
    func display()
}

// Real Subject

fileprivate class RealImage: Image {
    
    var filename: String
    
    init(_ filename: String) {
        self.filename = filename
        loadFromDisk()
    }
    
    func display() {
        print("Displaying \(filename)")
    }
    
    private func loadFromDisk() {
        print("Loading \(filename)")
    }
}

// Proxy

fileprivate class ProxyImage: Image {
    
    var image: Image?
    var filename: String
    
    init(_ filename: String) {
        self.filename = filename
    }
    
    func display() {
        if image == nil {
            image = RealImage(filename)
        }
        image!.display()
    }
}

// Client

class ProxySample {
    
    init() {
        let image1: Image = ProxyImage("Photo_1_10MB.bmp")
        image1.display() // loading
        image1.display()
        image1.display()
        
        let image2: Image = ProxyImage("Photo_2_10MB.bmp")
        image2.display() // loading
        image2.display()
    }
}
