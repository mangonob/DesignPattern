//
//  Sort.swift
//  DesignPattern
//
//  Created by G on 2020/6/18.
//  Copyright © 2020 Trinity. All rights reserved.
//

import Foundation

/**
 * 使用 **模版方法** 实现排序功能（不使用闭包特性）
 */
struct Sort<Element> {
    private var contents: [Element]

    init<S>(_ sequence: S) where S.Element == Element, S: Sequence {
        contents = Array(sequence)
    }
    
    /**
     * 选择排序
     * - Parameter sortor: 排序器
     */
    @discardableResult
    func result(sortor: Sortor<Element>) -> [Element] {
        var sorted = contents

        for i in 0..<sorted.count {
            var min = sorted[i]
            var position = i
            
            for j in i..<sorted.count {
                let current = sorted[j]

                if sortor.compare(lhs: min, rhs: current) == .orderedDescending {
                    min = current
                    position = j
                }
            }
            
            if i != position {
                let t = sorted[i]
                sorted[i] = sorted[position]
                sorted[position] = t
            }
        }

        return sorted
    }
}

class Sortor<Element> {
    func compare(lhs: Element, rhs: Element) -> ComparisonResult  {
        return .orderedSame
    }
}

struct User: CustomStringConvertible {
    var name: String
    var sex: Bool
    var age: Int
    
    var description: String {
        return "\(name): \(age)"
    }
}

/**
 装饰器，修改排序行为为逆序
 */
class ReverseSortor<Element>: Sortor<Element> {
    private var sortor: Sortor<Element>
    
    init(_ sortor: Sortor<Element>) {
        self.sortor = sortor
    }
    
    override func compare(lhs: Element, rhs: Element) -> ComparisonResult {
        if let reversed = sortor as? ReverseSortor<Element> {
            return reversed.sortor.compare(lhs: lhs, rhs: rhs)
        }
        
        switch sortor.compare(lhs: lhs, rhs: rhs) {
        case .orderedAscending:
            return .orderedDescending
        case .orderedDescending:
            return .orderedAscending
        case .orderedSame:
            return .orderedSame
        }
    }
}

class KeyPathSortor<Element, Value: Comparable>: Sortor<Element> {
    private var keyPath: KeyPath<Element, Value>
    
    init(keyPath: KeyPath<Element, Value>) {
        self.keyPath = keyPath
    }
    
    override func compare(lhs: Element, rhs: Element) -> ComparisonResult {
        let lValue = lhs[keyPath: keyPath]
        let rValue = rhs[keyPath: keyPath]
        
        if lValue < rValue {
            return .orderedAscending
        } else if lValue > rValue {
            return .orderedDescending
        } else {
            return .orderedSame
        }
    }
}

class UserSortor: KeyPathSortor<User, String> {
    init() {
        super.init(keyPath: \.name)
    }
}


/**
 装饰器，随机排序
 */
class RandomSortor<Element>: Sortor<Element> {
    init(_ sortor: Sortor<Element>) {
    }
    
    override func compare(lhs: Element, rhs: Element) -> ComparisonResult {
        [ComparisonResult](arrayLiteral: .orderedAscending, .orderedDescending, .orderedSame)[Int(arc4random() % 3)]
    }
}

class SortRoutine: Routine {
    static func perform() {
        let sort = Sort([
            User(name: "Tom", sex: true, age: 18),
            User(name: "Jerry", sex: false, age: 23),
            User(name: "Sam", sex: true, age: 20),
            User(name: "Cook", sex: false, age: 29),
            User(name: "Scott", sex: false, age: 17),
            User(name: "Penny", sex: true, age: 21),
        ])
        
        let sortor = UserSortor()
        print("Ordered: \(sort.result(sortor: sortor))")
        print("Reversed: \(sort.result(sortor: ReverseSortor(sortor)))")
        print("Shuffled: \(sort.result(sortor: RandomSortor(sortor)))")
        print("Sort by age: \(sort.result(sortor: KeyPathSortor(keyPath: \User.age)))")
    }
}
