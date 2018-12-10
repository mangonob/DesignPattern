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
    associatedtype Element where Self.IteratorType.Element == Element
    associatedtype IteratorType: Iterator

    func createIterator() -> IteratorType
}

extension BaseGlyph: Iteratable {
    typealias Element = Glyph

    func createIterator() -> AnyIterator<Element> {
        return AnyIterator(ListIterator(children))
    }
}

struct AnyIterator<E>: Iterator {
    typealias Element = E

    private var firstHandler: () -> Void
    private var nextHandler: () -> Void
    private var currentItemHandler: () -> E?
    private var isDoneHandler: () -> Bool

    init<T: Iterator>(_ base: T) where T.Element == Element {
        firstHandler = base.first
        nextHandler = base.next
        currentItemHandler = base.currentItem
        isDoneHandler = base.isDone
    }

    func first() {
        firstHandler()
    }

    func next() {
        nextHandler()
    }
    
    func currentItem() -> E? {
        return currentItemHandler()
    }
    
    func isDone() -> Bool {
        return isDoneHandler()
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
        guard current >= 0 && current < content.count else { return nil }
        return content[current]
    }
    
    func isDone() -> Bool {
        return current >= content.count
    }
}

class PreorderIterator<T: Iteratable>: Iterator {
    typealias Element = T.Element
    
    let root: T
    private var iterators: [AnyIterator<Element>]

    init(_ root: T) {
        self.root = root
        iterators = [AnyIterator<Element>]()
    }
    
    func first() {
    }
    
    func next() {
    }
    
    func currentItem() -> T.Element? {
        return nil
    }
    
    func isDone() -> Bool {
        return true
    }
}

struct IteratorRoutine: Routine {
    static func perform() {
        let glyph = BaseGlyph()
        glyph.insert(BaseGlyph())
        glyph.insert(BaseGlyph())
        
        let iterator = glyph.createIterator()
        
        iterator.first()
        while !iterator.isDone() {
            print(iterator.currentItem() as Any)
            iterator.next()
        }
    }
}
