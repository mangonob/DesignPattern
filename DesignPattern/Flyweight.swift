//
//  Flyweight.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/24.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

class GlyphContext {
    private var fonts: BTree<Font>?
    
    func next(step: Int = 1) {
    }
    
    func insert(quantity: Int = 1) {
    }
    
    func setFont(font: Font?, span: Int = 1) {
    }
    
    func getFont() -> Font? {
        return nil
    }
}

class Font: Equatable {
    private (set) var name: String
    private (set) var size: CGFloat
    
    init(name: String, size: CGFloat) {
        self.name = name
        self.size = size
    }
    
    static func == (lhs: Font, rhs: Font) -> Bool {
        return lhs.name == rhs.name && lhs.size == rhs.size
    }
}

class BTree<Value> {
}

class Glyph {
    func setFont(_ font: Font?, context: GlyphContext) {
    }
    
    func getFont(_ context: GlyphContext) -> Font {
        fatalError()
    }
    
    func draw(_ window: Window, context: GlyphContext) {
    }
    
    func first(context: GlyphContext) {
    }
    
    func next(context: GlyphContext) {
    }
    
    func isDone(context: GlyphContext) -> Bool {
        return true
    }
    
    func currentItem(context: GlyphContext) -> Glyph? {
        return nil
    }

    func insert(_ glyph: Glyph, context: GlyphContext) {
    }
    
    func remove(context: GlyphContext) {
    }
}

class Row: Glyph {
}

class Column: Glyph {
}

class GlyphFactory {
    private (set) static var shared = GlyphFactory()
    
    init() {
    }
    
    private lazy var characters = [Int8: Character]()
    
    func createCharacter(value: Int8) -> Character {
        guard let character = characters[value] else {
            let character = Character(value)
            characters[value] = Character(value)
            return character
        }
        
        return character
    }
    
    func createRow() -> Row {
        return Row()
    }
    
    func createColumn() -> Column {
        return Column()
    }
}

class Character: Glyph {
    private (set) var value: Int8
    
    init(_ value: Int8) {
        self.value = value
    }
}

struct FlyweightRoutine: Routine {
    static func perform() {
        for _ in 0..<100000 {
            let value = Int8(arc4random() % UInt32(Int8.max))
            _ = GlyphFactory.shared.createCharacter(value: value)
        }
    }
}
