//
//  Composite.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/7.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

protocol Glyph: AnyObject {
    func insert(_ subGlyph: Glyph)
    func remove(_ subGlyph: Glyph)
    var parent: Glyph? { get set }
    func child(at index: Int) -> Glyph?
}

class BaseGlyph: Glyph {
    private(set) var children = [Glyph]()
    
    var parent: Glyph?

    func insert(_ subGlyph: Glyph) {
        guard !children.contains(where: { $0 === subGlyph }) else { return }
        
        subGlyph.parent?.remove(subGlyph)
        subGlyph.parent = self
        children.append(subGlyph)
    }
    
    func remove(_ subGlyph: Glyph) {
        guard children.contains(where: { $0 === subGlyph }) else { return }
        
        children.removeAll { $0 === subGlyph }
        subGlyph.parent = nil
    }
    
    func child(at index: Int) -> Glyph? {
        guard index > 0 && index < children.count else { return nil }
        return children[index]
    }
}
