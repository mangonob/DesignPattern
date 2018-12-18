//
//  Prototype.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/18.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

class MazePrototypeFactory: MazeFactory {
    private var mazePrototype: Maze
    private var roomPrototype: Room
    private var wallPrototype: Wall
    private var doorPrototype: Door
    
    init(maze: Maze, room: Room, wall: Wall, door: Door) {
        mazePrototype = maze
        roomPrototype = room
        wallPrototype = wall
        doorPrototype = door
    }
    
    override func makeMaze() -> Maze {
        fatalError()
    }
    
    override func makeRoom(withNo no: Int) -> Room {
        fatalError()
    }
    
    override func makeWall() -> Wall {
        fatalError()
    }
    
    override func makeDoor(room1: Room?, room2: Room?) -> Door {
        fatalError()
    }
}
