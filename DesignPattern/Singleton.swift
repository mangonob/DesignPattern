//
//  Singleton.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/19.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

struct SingletonRoutine: Routine {
    static func perform() {
        let factory = MazeFactory.shared
        let game = MazeGame()
        let maze = game.createMaze(factory: factory)
        print(maze)
    }
}
