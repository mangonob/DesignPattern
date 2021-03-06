//
//  ChainOfResponsibility.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/25.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

class HelpHandler {
    private weak var successor: HelpHandler?

    init(_ helpHandler: HelpHandler? = nil) {
        self.successor = helpHandler
    }
    
    func hasHelp() -> Bool {
        return true
    }
    
    func handleHelp() {
        self.successor?.handleHelp()
    }
    
    func setHandler(_ helpHandler: HelpHandler?) {
        self.successor = helpHandler
    }
}

class Widget: HelpHandler {
    var isEnable: Bool = true
    private (set) var parent: Widget?
    weak var director: DialogDirector?

    init() {
    }
    
    init(_ parent: Widget?) {
        super.init(parent)
        self.parent = parent
    }

    override init(_ helpHandler: HelpHandler?) {
        super.init(helpHandler)
    }
    
    override func hasHelp() -> Bool {
        return isEnable
    }
    
    func handleMouse(_ event: MouseEvent) {
    }
    
    func change() {
        director?.widgetChanged(self)
    }
}

class ButtonWidget: Widget {
    var text: String?
    
    override func handleHelp() {
        guard hasHelp() else {
            super.handleHelp()
            return
        }
        
        print("\(self) handle help")
    }
    
    override func handleMouse(_ event: MouseEvent) {
        change()
    }
}

class Dialog: Widget {
    override func handleHelp() {
        guard hasHelp() else {
            super.handleHelp()
            return
        }
        
        print("\(self) handle help")
    }
}

class Application: HelpHandler {
    override func handleHelp() {
        print("\(self) handle help")
    }
    
    private (set) var documents = [Document]()
    
    func add(document: Document) {
        guard !documents.contains(where: { $0 === document }) else { return }
        documents.append(document)
    }
}

struct ChainOfResponsibilityRoutine: Routine {
    static func perform() {
        let application = Application()
        let dialog = Dialog(application)
        let buttonWidget = ButtonWidget(dialog)
        
        buttonWidget.handleHelp()
        
        buttonWidget.isEnable = false
        buttonWidget.handleHelp()
        
        dialog.isEnable = false
        buttonWidget.handleHelp()
    }
}
