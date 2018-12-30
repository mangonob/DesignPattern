//
//  TemplateMethod.swift
//  DesignPattern
//
//  Created by Trinity on 2018/12/30.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

class MyView: View {
    override func doDisplay() {
        print("Display \(self)")
    }
}

struct TemplateMethodRoutine: Routine {
    static func perform() {
        MyView().display()
    }
}
