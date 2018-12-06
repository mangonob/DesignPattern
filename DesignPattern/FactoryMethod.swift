//
//  FactoryMethod.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/6.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

protocol Creator {
    func createProduct() -> Product
}

class Product { }

class ConcreteProduct: Product { }

class ConcreteCreator: Creator {
    func createProduct() -> Product {
        return ConcreteProduct()
    }
}

class FactoryMethodRoutine: Routine {
    static func perform() {
        let factory = ConcreteCreator()
        print(factory.createProduct())
    }
}
