//
//  Iterator.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/6.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

class Iterator<Element> {
    func first() { }
    func next() { }
    func isDone() -> Bool { return true }
    func currentItem() -> Element { fatalError() }
}

protocol Iteratable {
    associatedtype Element
    func createIterator() -> Iterator<Element>
}

extension BaseGlyph: Iteratable {
    typealias Element = Glyph
    
    func createIterator() -> Iterator<Glyph> {
        fatalError()
    }
}

class ListIterator<Element>: Iterator<Element> {
    private var content: [Element]
    
    init(_ content: [Element]) {
        self.content = content
    }
}

class PreorderIterator<Element>: Iterator<Element> {
    init(_ root: Glyph) {
        super.init()
    }
}
