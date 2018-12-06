//
//  Decorator.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/5.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

class Component {
    func description() -> String {
        return "Component"
    }
}

class ConcreteComponent: Component {
    override func description() -> String {
        return "ConcreteComponent"
    }
}

class Decorator: Component {
    var component: Component
    
    init(_ component: Component) {
        self.component = component
    }
}

class DecoratorA: Decorator {
    override func description() -> String {
        return "<\(component.description())> + A"
    }
}

class DecoratorB: Decorator {
    override func description() -> String {
        return "<\(component.description())> + B"
    }
}

class DecoratorC: Decorator {
    override func description() -> String {
        return "<\(component.description())> + C"
    }
}

class DecoratorRoutine: Routine {
    static func perform() {
        let component = ConcreteComponent()
        let a = DecoratorA(component)
        let c = DecoratorC(a)
        let b = DecoratorB(c)
        
        print(b.description())
    }
}
