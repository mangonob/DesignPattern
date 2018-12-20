//
//  Bridge.swift
//  DesignPattern
//
//  Created by Trinity on 2018/12/20.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

class Window {
    internal var _imp: WindowImp!
    var imp: WindowImp {
        if _imp == nil {
            _imp = WindowImp()
        }
        return _imp
    }

    func drawContent() { }
    
    func open() { }
    
    func close() { }
    
    func iconify() { }
    
    func deiconify() { }
    
    func raise() { }
    
    func lower() { }
    
    func drawLine(start: CGPoint, end: CGPoint) { }
    
    func drawRect(start: CGPoint, end: CGPoint) { }
    
    func drawPolygon(points: [CGPoint]) { }
    
    func drawText(_ text: String, origin: CGPoint) { }
}

class WindowImp {
    func impTop() { }
    
    func impBottom() { }
    
    func impSetExtent(_ extent: CGPoint) { }
    
    func impSetOrigin(_ origin: CGPoint) { }
    
    func deviceRect(_ rect: CGRect) { }
    
    func deviceText(_ text: String, origin: CGPoint) { }
    
    func deviceBitmap(_ text: [Int8], origin: CGPoint) { }
}
