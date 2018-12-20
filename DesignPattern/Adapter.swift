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
    var origin: CGPoint {
        return .zero
    }
    
    var extent: CGSize {
        return .zero
    }
    
    var isEmpty: Bool {
        return false
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
