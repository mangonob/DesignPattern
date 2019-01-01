//
//  Visitor.swift
//  DesignPattern
//
//  Created by Trinity on 2019/1/1.
//  Copyright © 2019 BaiYiYuan. All rights reserved.
//

import Foundation

class EquipmentVisitor {
    func visit(_ floppyDisk: FloppyDisk) {
    }
    
    func visit(_ card: Card) {
    }
    
    func visit(_ chassis: Chassis) {
    }
    
    func visit(_ bus: Bus) {
    }
}

class PricingVisitor: EquipmentVisitor {
    typealias Currency = Equipment.Currency
    
    private (set) var total: Currency = 0
    
    override func visit(_ floppyDisk: FloppyDisk) {
        total += floppyDisk.netPrice()
    }
    
    override func visit(_ chassis: Chassis) {
        total += chassis.discountPrice()
    }
}

class Inventory {
    func accumulate(_ equipment: Equipment) {
    }
}

class InventoryVisitor: EquipmentVisitor {
    private (set) lazy var inventory = Inventory()
    
    override func visit(_ floppyDisk: FloppyDisk) {
        inventory.accumulate(floppyDisk)
    }
    
    override func visit(_ chassis: Chassis) {
        inventory.accumulate(chassis)
    }
}

struct VisitorRoutine: Routine {
    static func perform() {
        let visitor = InventoryVisitor()
        let component = Equipment(name: "Empty equipment")
        component.accept(visitor)
        print(visitor.inventory)
    }
}
