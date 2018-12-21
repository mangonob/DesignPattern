//
//  Composite.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/7.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

class Equipment: Iteratable {
    typealias Watt = Double
    typealias Currency = Double

    var name: String = "Equipment"
    
    func power() -> Watt { return 0 }
    
    func netPrice() -> Currency { return 0 }
    
    func discountPrice() -> Currency { return 0 }
    
    func add(_ equipment: Equipment) { }
    
    func remove(_ equipment: Equipment) { }
    
    typealias Element = Equipment
    
    func createIterator() -> AnyIterator<Equipment> { return AnyIterator(NullIterator<Equipment>()) }
    
    init(name: String) {
        self.name = name
    }
}

class FloppyDisk: Equipment {
    override func netPrice() -> Equipment.Currency {
        return 42
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
}

class Chassis: CompositeEquipment {
    override func netPrice() -> CompositeEquipment.Currency {
        return 12.4 + super.netPrice()
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
}

class Card: Equipment {
    override func netPrice() -> Equipment.Currency {
        return 99
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
        
        print(chassis.netPrice())
    }
}
