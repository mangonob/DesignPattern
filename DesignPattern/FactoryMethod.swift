//
//  FactoryMethod.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/6.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

class BombedGame: MazeGame {
    override func makeWall() -> Wall {
        return BombedWall()
    }
    
    override func makeRoom(withNo no: Int) -> Room {
        return RoomWithABoom(no)
    }
}

class EnchantedMazeGame: MazeGame {
    override func makeRoom(withNo no: Int) -> Room {
        return EnchantRoom(no, spell: castSpell())
    }
    
    override func makeDoor(room1: Room?, room2: Room?) -> Door {
        return DoorNeedingSpell(room1: room1, room2: room2)
    }

    func castSpell() -> Spell {
        return Spell()
    }
}

class FactoryMethodRoutine: Routine {
    static func perform() {
        let game = BombedGame()
        let maze = game.createMaze()
        print(maze)
    }
}
