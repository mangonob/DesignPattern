//
//  Mediator.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/28.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

class MouseEvent: Event {
}

class DialogDirector {
    func widgetChanged(_ widget: Widget) {
    }
}

class ListBox: Widget {
    var items = [ListItem]()
    private var selectedIndex: Int = NSNotFound
    
    var selection: String? {
        guard selectedIndex >= 0 && selectedIndex < items.count else {
            return nil
        }
        
        return items[selectedIndex].title
    }
    
    func setItem(at index: Int) {
        selectedIndex = index
        change()
    }
}

class ListItem {
    var title: String
    
    init(title: String = "Item") {
        self.title = title
    }
}

class EntryField: Widget {
    var text: String?
}

extension Widget: Equatable {
    static func == (lhs: Widget, rhs: Widget) -> Bool {
        return lhs === rhs
    }
}

class FontDialogDirector: DialogDirector {
    private (set) var fontNameField: EntryField!
    private (set) var okButton: ButtonWidget!
    private (set) var cancelButton: ButtonWidget!
    private (set) var fontList: ListBox!
    
    func createWidgets() {
        fontNameField = EntryField()
        okButton = ButtonWidget()
        cancelButton = ButtonWidget()
        fontList = ListBox()
        
        fontNameField.director = self
        okButton.director = self
        cancelButton.director = self
        fontList.director = self
        
        fontList.items = [
            ListItem(title: "Helvetica"),
            ListItem(title: "Helvetica Neue"),
            ListItem(title: "Menlo"),
            ListItem(title: "Monaco"),
        ]
        fontList.setItem(at: 0)
    }
    
    override func widgetChanged(_ widget: Widget) {
        switch widget {
        case fontList:
            fontNameField.text = fontList.selection
        case okButton:
            print("Apply font \(fontNameField.text ?? "<None>")")
        case cancelButton:
            print("Dismiss dialog")
        default:
            break
        }
    }
}

struct MediatorRoutine: Routine {
    static func perform() {
        let director = FontDialogDirector()
        director.createWidgets()
        if let fontName = director.fontNameField.text {
            print("Font name \(fontName)")
        }
        director.okButton.handleMouse(MouseEvent())
    }
}
