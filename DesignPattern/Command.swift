//
//  Command.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/6.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

protocol Command {
    func execute()
    func unexecute()
}

class PasteCommand: Command {
    func execute() {
        print("Execute paste")
    }
    
    func unexecute() {
        print("Unexecute paste")
    }
}

class FontCommand: Command {
    func execute() {
        print("Execute font")
    }
    
    func unexecute() {
        print("Unexecute font")
    }
}

class SaveCommand: Command {
    func execute() {
        print("Execute save")
    }
    
    func unexecute() {
        print("Unexecute save")
    }
}

class QuitCommand: Command {
    func execute() {
        print("Execute quit")
    }
    
    func unexecute() {
        print("Unexecute quit")
    }
}

class MenuItem {
    var command: Command?
    
    func clicked() {
        command?.execute()
    }
}
