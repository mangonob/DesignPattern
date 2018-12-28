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

class PreorderIterator<E>: Iterator {
    typealias Element = E
    
    let root: Element
    private var children: [AnyIterator<Element>]
    
    init(_ root: Element, children: [AnyIterator<Element>]) {
        self.root = root
        self.children = children
    }
    
    func first() {
    }
    
    func next() {
    }
    
    func currentItem() -> Element? {
        return nil
    }
    
    func isDone() -> Bool {
        return true
    }
}

class NullIterator<T>: Iterator {
    typealias Element = T
    
    func first() {
    }
    
    func next() {
    }
    
    func currentItem() -> T? {
        return nil
    }
    
    func isDone() -> Bool {
        return true
    }
}

extension AnyIterator {
    /** Internal iterator */
    func traverser(_ handler: (E) -> Void) {
        first()
        
        while !isDone() {
            if let item = currentItem() {
                handler(item)
            }
            
            next()
        }
    }
}

struct IteratorRoutine: Routine {
    static func perform() {
        AnyIterator(ListIterator([234,21234,12,34,124,123,4])).traverser { print($0) }
    }
}
