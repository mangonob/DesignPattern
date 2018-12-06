//
//  AbstractFactory.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/6.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

protocol GUIFactory {
    func createScrollBar() -> ScrollBar
    func createButton() -> Button
    func createMenu() -> Menu
}

class ScrollBar { }
class Button { }
class Menu { }

class MotifScrollBar: ScrollBar { }
class MotifButton: Button { }
class MotifMenu: Menu { }

class PMScrollBar: ScrollBar { }
class PMButton: Button { }
class PMMenu: Menu { }

class MacScrollBar: ScrollBar { }
class MacButton: Button { }
class MacMenu: Menu { }

class MotifFactory: GUIFactory {
    func createScrollBar() -> ScrollBar {
        return MotifScrollBar()
    }
    
    func createButton() -> Button {
        return MotifButton()
    }
    
    func createMenu() -> Menu {
        return MotifMenu()
    }
}

class PMFactory: GUIFactory {
    func createScrollBar() -> ScrollBar {
        return PMScrollBar()
    }
    
    func createButton() -> Button {
        return PMButton()
    }
    
    func createMenu() -> Menu {
        return PMMenu()
    }
}

class MacFactory: GUIFactory {
    func createScrollBar() -> ScrollBar {
        return MacScrollBar()
    }
    
    func createButton() -> Button {
        return MacButton()
    }
    
    func createMenu() -> Menu {
        return MacMenu()
    }
}
