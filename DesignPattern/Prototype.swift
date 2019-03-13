//
//  Prototype.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/18.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

protocol Copyable {
    func clone() -> Self
}

func cast<T: Any>(_ value: Any) -> T {
    if let cast = value as? T {
        return cast
    } else {
        fatalError("Can't cast \(value) to \(T.self).")
    }
}

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
        return mazePrototype.clone()
    }
    
    override func makeRoom(withNo no: Int) -> Room {
        let room = roomPrototype.clone()
        room.roomNo = no
        return room
    }
    
    override func makeWall() -> Wall {
        return wallPrototype.clone()
    }
    
    override func makeDoor(room1: Room?, room2: Room?) -> Door {
        let door = doorPrototype.clone()
        door.room1 = room1
        door.room2 = room2
        return door
    }
}

struct PrototypeRoutine: Routine {
    static func perform() {
        let game = MazeGame()
        let prototypeFactory = MazePrototypeFactory(maze: Maze(), room: RoomWithABoom(0), wall: BombedWall(), door: Door())
        let maze = game.createMaze(factory: prototypeFactory)
        print(maze)
    }
}
