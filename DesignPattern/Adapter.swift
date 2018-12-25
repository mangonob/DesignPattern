//
//  Adapter.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/19.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

class Manipulator {
}

class TextManipulator: Manipulator {
    private (set) var textView: TextView
    
    init(_ textView: TextView) {
        self.textView = textView
    }
}

class Shape {
    var bottomLeft: CGPoint {
        return .zero
    }
    
    var topRight: CGPoint {
        return .zero
    }
    
    func createManipulator() -> Manipulator {
        return Manipulator()
    }
}

class TextView {
    var origin: CGPoint = .zero
    
    var extent: CGSize = .zero
    
    var isEmpty: Bool {
        return extent == .zero
    }
}

class TextShape: Shape {
    private (set) var textView: TextView
    
    init(_ textView: TextView) {
        self.textView = textView
    }
    
    override var bottomLeft: CGPoint {
        return CGPoint(x: textView.origin.x, y: textView.origin.y + textView.extent.height)
    }
    
    override var topRight: CGPoint {
        return CGPoint(x: textView.origin.x + textView.extent.width, y: textView.origin.y)
    }

    override func createManipulator() -> Manipulator {
        return TextManipulator(textView)
    }
    
    var isEmpty: Bool {
        return textView.isEmpty
    }
}

struct AdapterRoutine: Routine {
    static func perform() {
        let textView = TextView()
        textView.origin = .init(x: 10, y: 20)
        textView.extent = .init(width: 30, height: 40)
        let textShape = TextShape(textView)
        print("BL \(textShape.bottomLeft)" )
        print("TR \(textShape.topRight)")
    }
}
