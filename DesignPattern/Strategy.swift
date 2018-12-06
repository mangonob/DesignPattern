//
//  Strategy.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/5.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

protocol FlyBehavior {
    func fly()
}

protocol QuackBehavior {
    func quack()
}

protocol DuckProtocol {
    var flyBehavior: FlyBehavior { get set }
    var quackBehavior: QuackBehavior { get set }
    func performFly()
    func performQuark()
}

extension DuckProtocol {
    func performFly() {
        flyBehavior.fly()
    }
    
    func performQuark() {
        quackBehavior.quack()
    }
}

class Duck: DuckProtocol {
    var flyBehavior: FlyBehavior
    var quackBehavior: QuackBehavior
    
    init() {
        flyBehavior = FlyWithWings()
        quackBehavior = Quack()
    }
}

class FlyWithWings: FlyBehavior {
    func fly() {
        print("Fly with wings.")
    }
}

class FlyNoWay: FlyBehavior {
    func fly() {
        print("I can't fly.")
    }
}

class Quack: QuackBehavior {
    func quack() {
        print("Quack.")
    }
}

class MuteQuack: QuackBehavior {
    func quack() {
        print("Mute quack.")
    }
}

class Squeak: QuackBehavior {
    func quack() {
        print("Squeak")
    }
}

struct StrategyRoutine: Routine {
    static func perform() {
        let duck = Duck()
        
        duck.performFly()
        duck.performQuark()
        duck.flyBehavior = FlyNoWay()
        duck.performFly()
    }
}
