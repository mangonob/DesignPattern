//
//  Observer.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/5.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

protocol Subject: AnyObject {
    func registerObserver(_ observer: Observer)
    func resignObserver(_ observer: Observer)
    func notifyObserver()
}

protocol Observer: AnyObject {
    func update(subject: Subject, userInfo: [AnyHashable: Any])
}

class SubjectCenter: Subject {
    private var observers = [Observer]()

    func registerObserver(_ observer: Observer) {
        guard !observers.contains(where: { $0 === observer }) else {
            return
        }
        
        observers.append(observer)
    }

    func resignObserver(_ observer: Observer) {
        observers.removeAll { $0 === observer }
    }
    
    func notifyObserver() {
        observers.forEach { $0.update(subject: self, userInfo: ["createdAt": Date()]) }
    }
}

class SimpleObserver: Observer {
    func update(subject: Subject, userInfo: [AnyHashable : Any]) {
        print("Receive notification from subject: \(subject) with userInfo: \(userInfo)")
    }
}

class SecondaryObserver: Observer {
    func update(subject: Subject, userInfo: [AnyHashable : Any]) {
        print("Receive notification from subject: \(subject)")
    }
}

struct ObserverRoutine: Routine {
    static func perform() {
        let subject = SubjectCenter()
        
        let observer1 = SimpleObserver()
        let observer2 = SecondaryObserver()
        let observer3 = SimpleObserver()
        
        subject.registerObserver(observer1)
        subject.registerObserver(observer2)
        subject.registerObserver(observer3)
        
        subject.notifyObserver()
    }
}
