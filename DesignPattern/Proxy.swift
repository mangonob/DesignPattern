//
//  Proxy.swift
//  DesignPattern
//
//  Created by Trinity on 2018/12/24.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

class Event {
}

class Graphic {
    func draw(at point: CGPoint) {
    }
    
    func handleMouse(event: Event) {
    }
    
    func getExtent() -> CGRect {
        return .zero
    }
    
    func load(_ from: FileHandle) {
    }
    
    func save(_ to: FileHandle) {
    }
}

class Image: Graphic {
    private var filename: String
    
    init(_ filename: String) {
        self.filename = filename
    }
}

class ImageProxy: Graphic {
    private (set) var filename: String
    private var extent: CGRect = .zero
    private var image: Image?
    
    init(filename: String) {
        self.filename = filename
    }
    
    func getImage() -> Image {
        if image == nil {
            image = Image(filename)
        }
        
        return image!
    }
    
    override func getExtent() -> CGRect {
        if extent == .zero {
            extent = getImage().getExtent()
        }
        
        return extent
    }
    
    override func draw(at point: CGPoint) {
        getImage().draw(at: point)
    }
    
    override func save(_ to: FileHandle) {
        getImage().save(to)
    }
    
    override func load(_ from: FileHandle) {
        getImage().load(from)
    }
}

class TextDocument {
    func insert(_ graphic: Graphic) {
    }
}

struct ProxyRoutine: Routine {
    static func perform() {
        let document = TextDocument()
        document.insert(ImageProxy(filename: "image_filename"))
    }
}
