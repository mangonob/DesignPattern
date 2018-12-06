//
//  Iterator.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/6.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

protocol Iterator {
    associatedtype Element: AnyObject
    
    func first()
    func next()
    func isDone() -> Bool
    func currentItem() -> Element
}
