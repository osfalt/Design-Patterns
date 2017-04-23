//
//  Observer.swift
//  DesignPatterns
//
//  Created by Dre on 22.04.17.
//  Copyright © 2017 Dre. All rights reserved.
//

/*
 Наблюдатель (Observer, Publisher-Subscriber, Dependents)
 
 Определяет зависимость типа «один ко многим» между объектами таким образом, что при изменении состояния одного объекта все зависящие от него оповещаются об этом событии.
 
 Шаблон «наблюдатель» применяется в тех случаях, когда система обладает следующими свойствами:
 - существует, как минимум, один объект, рассылающий сообщения;
 - имеется не менее одного получателя сообщений, причём их количество и состав могут изменяться во время работы приложения;
 - нет надобности очень сильно связывать взаимодействующие объекты, что полезно для повторного использования.
 */

import Foundation

// MARK: - Custom Observer

// Observer

fileprivate protocol Observer: AnyObject {
    func update(temperature: Double, humidity: Double, pressure: Double)
}

// Concrete Observer

fileprivate class CurrentWeatherDisplay: Observer {
    
    private var weatherData: WeatherData
    private var temperature: Double = 0
    private var humidity: Double = 0
    private var pressure: Double = 0
    
    public init(weatherData: WeatherData) {
        self.weatherData = weatherData
        self.weatherData.register(observer: self)
    }
    
    func update(temperature: Double, humidity: Double, pressure: Double) {
        self.temperature = temperature
        self.humidity = humidity
        self.pressure = pressure
        display()
    }
    
    func display() {
        print("temperature = \(temperature), humidity = \(humidity), pressure = \(pressure)")
    }
}

// Observable

fileprivate protocol Observable {
    func register(observer: Observer)
    func remove(observer: Observer)
    func notifyObservers()
}

// Concrete Observable

fileprivate class WeatherData: Observable {
    
    private var observers = [Observer]()
    private var temperature: Double = 0
    private var humidity: Double = 0
    private var pressure: Double = 0
    
    func register(observer: Observer) {
        observers.append(observer)
    }
    
    func remove(observer: Observer) {
        if let index = (observers.index { $0 === observer }) {
            observers.remove(at: index)
        }
    }
    
    func notifyObservers() {
        for observer in observers {
            observer.update(temperature: temperature, humidity: humidity, pressure: pressure)
        }
    }
    
    func setup(temperature: Double, humidity: Double, pressure: Double) {
        self.temperature = temperature
        self.humidity = humidity
        self.pressure = pressure
        notifyObservers()
    }
}

// MARK: - Observer via Notification Center

// Concrete Observer

fileprivate class NCCurrentWeatherDisplay: Observer {
    
    private var weatherData: NCWeatherData
    private var temperature: Double = 0
    private var humidity: Double = 0
    private var pressure: Double = 0
    
    init(weatherData: NCWeatherData) {
        self.weatherData = weatherData
        self.weatherData.register(observer: self)
    }
    
    func update(temperature: Double, humidity: Double, pressure: Double) {
        self.temperature = temperature
        self.humidity = humidity
        self.pressure = pressure
        display()
    }
    
    func display() {
        print("temperature = \(temperature), humidity = \(humidity), pressure = \(pressure)")
    }
    
    @objc func notificationDataUpdate(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        
        update(temperature: userInfo["temperature"] as! Double,
               humidity: userInfo["humidity"] as! Double,
               pressure: userInfo["pressure"] as! Double)
    }
}

// Concrete Observable

fileprivate class NCWeatherData: Observable {
    
    let notificationDataUpdated = NSNotification.Name("NCWeatherData.notificationDataUpdated")
    
    private var observers = [Observer]()
    private var temperature: Double = 0
    private var humidity: Double = 0
    private var pressure: Double = 0
    
    func register(observer: Observer) {
        observers.append(observer)
        
        NotificationCenter.default.addObserver(observer,
                                               selector: #selector(NCCurrentWeatherDisplay.notificationDataUpdate(_:)),
                                               name: notificationDataUpdated,
                                               object: nil)
    }
    
    func remove(observer: Observer) {
        if let index = (observers.index { $0 === observer }) {
            observers.remove(at: index)
        }
        
        NotificationCenter.default.removeObserver(observer, name: notificationDataUpdated, object: nil)
    }
    
    func notifyObservers() {
        var userInfo = [String: Double]()
        userInfo["temperature"] = temperature
        userInfo["humidity"] = humidity
        userInfo["pressure"] = pressure
        NotificationCenter.default.post(name: notificationDataUpdated, object: nil, userInfo: userInfo)
    }
    
    func setup(temperature: Double, humidity: Double, pressure: Double) {
        self.temperature = temperature
        self.humidity = humidity
        self.pressure = pressure
        notifyObservers()
    }
}

// Client

class ObserverSample {
    
    init() {
        print("--- Custom Observer ---")
        let weatherData = WeatherData()
        _ = CurrentWeatherDisplay(weatherData: weatherData)
        
        weatherData.setup(temperature: 15.0, humidity: 60.0, pressure: 750.0)
        weatherData.setup(temperature: 18.0, humidity: 70.0, pressure: 755.0)
        weatherData.setup(temperature: 21.0, humidity: 65.0, pressure: 760.0)
        
        print("--- Observer via Notification Center ---")
        let ncWeatherData = NCWeatherData()
        _ = NCCurrentWeatherDisplay(weatherData: ncWeatherData)
        
        ncWeatherData.setup(temperature: 15.0, humidity: 60.0, pressure: 750.0)
        ncWeatherData.setup(temperature: 18.0, humidity: 70.0, pressure: 755.0)
        ncWeatherData.setup(temperature: 21.0, humidity: 65.0, pressure: 760.0)
    }
    
}
