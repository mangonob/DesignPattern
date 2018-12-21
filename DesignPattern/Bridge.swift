//
//  Bridge.swift
//  DesignPattern
//
//  Created by Trinity on 2018/12/20.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

class View {
    func drawOn(_ window: Window) {
    }
}

class WindowSystemFactory {
    static var shared = WindowSystemFactory()
    
    private init() {
    }
    
    func makeWindowImp() -> WindowImp {
        return XWindowImp()
    }
}

class Window {
    private (set) var view: View
    
    init(_ view: View) {
        self.view = view
    }
    
    internal var _imp: WindowImp!
    var imp: WindowImp {
        if _imp == nil {
            _imp = WindowSystemFactory.shared.makeWindowImp()
        }
        return _imp
    }

    func drawContents() { }
    
    func open() { }
    
    func close() { }
    
    func iconify() { }
    
    func deiconify() { }
    
    func raise() { }
    
    func lower() { }
    
    func drawLine(start: CGPoint, end: CGPoint) { }
    
    func drawRect(start: CGPoint, end: CGPoint) {
        imp.deviceRect(CGRect(origin: start, size: CGSize(width: end.x - start.x, height: end.y - start.y)))
    }
    
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

class ApplicationWindow: Window {
    override func drawContents() {
        view.drawOn(self)
    }
}

class IconWindow: Window {
    var bitMap: [Int8]?
    
    override func drawContents() {
        if let bitMap = bitMap {
            imp.deviceBitmap(bitMap, origin: CGPoint(x: 0, y: 0))
        }
    }
}

class Display {
}

class Drawable {
}

class GC {
}

class XWindowImp: WindowImp {
    lazy var display = Display()
    lazy var winid = Drawable()
    lazy var gc = GC()
    
    override func deviceRect(_ rect: CGRect) {
        xDrawRectangle(display: display, winid: winid, gc: gc, x: rect.origin.x, y: rect.origin.y, w: rect.width, h: rect.height)
    }
    
    func xDrawRectangle(display: Display, winid: Drawable, gc: GC, x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        print("X Window draw rect (\(x), \(y), \(w), \(h)) on screen.")
    }
}

class HPS {
}

class PMWindowImp: WindowImp {
    lazy var hps = HPS()
    
    override func deviceRect(_ rect: CGRect) {
        print("PM draw rect \(rect)")
    }
}

struct BridgeRoutine: Routine {
    static func perform() {
        let window = ApplicationWindow(View())
        window.drawRect(start: .init(x: 4, y: 8), end: .init(x: 10, y: 100))
    }
}
