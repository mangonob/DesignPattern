//
//  Decorator.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/5.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

class VisualComponent {
    func draw() {
    }
    
    func resize() {
    }
}

class Decorator: VisualComponent {
    private var component: VisualComponent
    
    init(_ component: VisualComponent) {
        self.component = component
    }
    
    override func draw() {
        component.draw()
    }
    
    override func resize() {
        component.resize()
    }
}

class BorderDecorator: Decorator {
    private var border: CGFloat
    
    init(_ component: VisualComponent, border: CGFloat = 0) {
        self.border = border
        super.init(component)
    }
    
    override func draw() {
        print("[@(\(border)) ")
        super.draw()
        print(" ]")
    }
}

class Button: VisualComponent {
    var title: String = "Button"
    
    override func draw() {
        print(title)
    }
}

class DecoratorRoutine: Routine {
    static func perform() {
        let button = Button()
        button.title = "Title for button"
        let borderButton = BorderDecorator(button, border: 10.4)
        borderButton.draw()
    }
}
