//
//  Composite.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/7.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

class Equipment: Iteratable, CustomStringConvertible {
    typealias Watt = Double
    typealias Currency = Double

    var name: String = "Equipment"
    
    func power() -> Watt { return 0 }
    
    func netPrice() -> Currency { return 0 }
    
    func discountPrice() -> Currency { return 0 }
    
    func add(_ equipment: Equipment) { }
    
    func remove(_ equipment: Equipment) { }
    
    func accept(_ visitor: EquipmentVisitor) {
    }

    typealias Element = Equipment
    
    func createIterator() -> AnyIterator<Equipment> { return AnyIterator(NullIterator<Equipment>()) }
    
    init(name: String) {
        self.name = name
    }
    
    var description: String {
        return "\(name) ¥\(netPrice())"
    }
}

class FloppyDisk: Equipment {
    override func netPrice() -> Equipment.Currency {
        return 42
    }
    
    override func accept(_ visitor: EquipmentVisitor) {
        visitor.visit(self)
    }
}

class CompositeEquipment: Equipment {
    private lazy var equipments = [Equipment]()
    
    override func add(_ equipment: Equipment) {
        guard !equipments.contains(where: { $0 === equipment }) else { return }
        equipments.append(equipment)
    }
    
    override func remove(_ equipment: Equipment) {
        equipments.removeAll { $0 === equipment }
    }
    
    override func createIterator() -> AnyIterator<Equipment> {
        return AnyIterator(ListIterator(equipments))
    }
    
    override func netPrice() -> Currency {
        let iterator = createIterator()
        iterator.first()
        
        var total: Currency = 0
        
        while !iterator.isDone() {
            defer {
                iterator.next()
            }
            
            guard let item = iterator.currentItem() else {
                continue
            }
            
            total += item.netPrice()
        }
        
        return total
    }
    
    override var description: String {
        var descriptions = [String]()
        
        let iterator = createIterator()
        iterator.first()
        
        while !iterator.isDone() {
            defer {
                iterator.next()
            }
            
            guard let item = iterator.currentItem() else {
                continue
            }
            
            descriptions.append(item.description)
        }
        
        return "[\(name): \(descriptions.joined(separator: ", "))]"
    }
}

class Chassis: CompositeEquipment {
    override func netPrice() -> CompositeEquipment.Currency {
        return 12.4 + super.netPrice()
    }
    
    override func accept(_ visitor: EquipmentVisitor) {
        createIterator().traverser { $0.accept(visitor) }
        visitor.visit(self)
    }
}

class Cabinet: CompositeEquipment {
    override func netPrice() -> CompositeEquipment.Currency {
        return 100 + super.netPrice()
    }
}

class Bus: CompositeEquipment {
    override func netPrice() -> CompositeEquipment.Currency {
        return 37 + super.netPrice()
    }
    
    override func accept(_ visitor: EquipmentVisitor) {
        visitor.visit(self)
    }
}

class Card: Equipment {
    override func netPrice() -> Equipment.Currency {
        return 99
    }
    
    override func accept(_ visitor: EquipmentVisitor) {
        visitor.visit(self)
    }
}

struct CompositeRoutine: Routine {
    static func perform() {
        let cabinet = Cabinet(name: "PC Cabinet")
        let chassis = Chassis(name: "PC Chassis")
        
        cabinet.add(chassis)
        
        let bus = Bus(name: "MCA Bus")
        bus.add(Card(name: "16Mbs Token Ring"))
        
        chassis.add(bus)
        chassis.add(FloppyDisk(name: "3.5 in Floppy"))
        
        print(cabinet)
        print(cabinet.netPrice())
    }
}
