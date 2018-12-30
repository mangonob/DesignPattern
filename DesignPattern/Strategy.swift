//
//  Strategy.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/5.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

class Component {
}

class Composition {
    var compositor: Compositor?
    lazy var components = [Component]()
    var lineBreaks = [Int]()
    var componentCount: Int = 0
    var linkWidth: Int = 0
    var lineCount: Int = 0

    init(compositor: Compositor? = nil) {
        self.compositor = compositor
    }
    
    func repair() {
        let natural = [CGSize]()
        let stretch = [CGPoint]()
        let shrink = [CGPoint]()
        
        _ = compositor?.compose(natural: natural, stretch: stretch, shrink: shrink,
                            componentCount: componentCount, lineWidth: linkWidth, breaks: lineBreaks)
    }
}

class Compositor {
    func compose(natural: [CGSize], stretch: [CGPoint], shrink: [CGPoint],
                 componentCount: Int, lineWidth: Int, breaks: [Int]) -> Int {
        return 0
    }
}

class SimpleCompositor: Compositor {
    override func compose(natural: [CGSize], stretch: [CGPoint], shrink: [CGPoint],
                          componentCount: Int, lineWidth: Int, breaks: [Int]) -> Int {
        return 0
    }
}

class TeXCompositor: Compositor {
    override func compose(natural: [CGSize], stretch: [CGPoint], shrink: [CGPoint],
                          componentCount: Int, lineWidth: Int, breaks: [Int]) -> Int {
        return 0
    }
}

class ArrayComposiror: Compositor {
    override func compose(natural: [CGSize], stretch: [CGPoint], shrink: [CGPoint],
                          componentCount: Int, lineWidth: Int, breaks: [Int]) -> Int {
        return 0
    }
}

struct StrategyRoutine: Routine {
    static func perform() {
        let composition = Composition(compositor: SimpleCompositor())
        composition.repair()
    }
}
