//
//  Iterator.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/6.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

protocol Iterator {
    associatedtype Element
    
    func first()
    func next()
    func isDone() -> Bool
    func currentItem() -> Element?
}

protocol Iteratable {
    associatedtype Element where Element == Self.IteratorType.Element
    associatedtype IteratorType: Iterator

    func createIterator() -> Self.IteratorType
}

extension BaseGlyph: Iteratable {
    typealias Element = Glyph

    func createIterator() -> AnyIterator<Element> {
        return AnyIterator(ListIterator(children))
    }
}

struct AnyIterator<E>: Iterator {
    typealias Element = E

    init<T: Iterator>(_ iterator: T) where T.Element == Element {
    }

    func first() {
    }

    func next() {
    }
    
    func currentItem() -> E? {
        return nil
    }
    
    func isDone() -> Bool {
        return true
    }
}

class ListIterator<E>: Iterator {
    typealias Element = E
    private var content: [Element]
    private var current: Int = 0
    
    init(_ content: [Element]) {
        self.content = content
    }
    
    func first() {
        current = 0
    }
    
    func next() {
        current += 1
    }
    
    func currentItem() -> Element? {
        return content[current]
    }
    
    func isDone() -> Bool {
        return current >= content.count
    }
}

class PreorderIterator<T: Iteratable>: Iterator {
    typealias Element = T.Element
    
    let root: T

    init(_ root: T) {
        self.root = root
    }
    
    func first() {
    }
    
    func next() {
    }
    
    func currentItem() -> T.Element? {
        fatalError()
    }
    
    func isDone() -> Bool {
        fatalError()
    }
}

struct IteratorRoutine: Routine {
    static func perform() {
        let iterator = BaseGlyph.init().createIterator()
        print(iterator)
    }
}
