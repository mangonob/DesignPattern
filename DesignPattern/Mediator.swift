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
    
    var selection: String?
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
    var fontNameField: EntryField!
    var okButton: ButtonWidget!
    var cancelButton: ButtonWidget!
    var fontList: ListBox!
    
    func createWidgets() {
        fontNameField = EntryField()
        okButton = ButtonWidget()
        cancelButton = ButtonWidget()
        fontList = ListBox()
    }
    
    override func widgetChanged(_ widget: Widget) {
        switch widget {
        case fontNameField:
            break
        default:
            break
        }
    }
}

struct MediatorRoutine: Routine {
    static func perform() {
    }
}
