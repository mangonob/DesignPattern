//
//  Command.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/6.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

class Command {
    func execute() {
    }
    
    func unexecute() {
    }
}

class Document {
    private (set) var name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    func open() {
        print("\(self): \(name) is opened")
    }
    
    func paste() {
        print("\(self): \(name) is pasted")
    }
}

class OpenCommand: Command {
    private (set) var application: Application
    
    init(application: Application) {
        self.application = application
    }
    
    func askUser() -> String {
        while true {
            guard let input = String(data: FileHandle.standardInput.availableData, encoding: .utf8),
                !input.isEmpty else {
                    continue
            }
            
            return input
        }
    }
    
    override func execute() {
        let document = Document(askUser())
        application.add(document: document)
        document.open()
    }
}

class PasteCommand: Command {
    private (set) var document: Document
    
    init(document: Document) {
        self.document = document
    }
    
    override func execute() {
        document.paste()
    }
}

class SimpleCommand<T: NSObject>: Command {
    private (set) var receiver: T
    private (set) var action: Selector
    
    init(_ receiver: T, action: Selector) {
        self.receiver = receiver
        self.action = action
    }
    
    override func execute() {
        receiver.perform(action)
    }
}

class MacroCommand: Command {
    private lazy var commands = [Command]()
    
    func add(_ command: Command) {
        guard !commands.contains(where: { $0 === command }) else { return }
        commands.append(command)
    }
    
    func remove(_ command: Command) {
        commands.removeAll(where: { $0 === command })
    }
    
    override func execute() {
        commands.forEach { $0.execute() }
    }
    
    override func unexecute() {
        commands.reversed().forEach { $0.unexecute() }
    }
}

struct CommandRoutine: Routine {
    static func perform() {
    }
}
