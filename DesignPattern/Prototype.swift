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
        return mazePrototype.copy() as! Maze
    }
    
    override func makeRoom(withNo no: Int) -> Room {
        let room = roomPrototype.copy() as! Room
        room.setValue(no, forKey: "roomNo")
        return room
    }
    
    override func makeWall() -> Wall {
        return wallPrototype.copy() as! Wall
    }
    
    override func makeDoor(room1: Room?, room2: Room?) -> Door {
        let door = doorPrototype.copy() as! Door
        door.room1 = room1
        door.room2 = room2
        return door
    }
}

struct PrototypeRoutine: Routine {
    static func perform() {
        let game = MazeGame()
        let prototypeFactory = MazePrototypeFactory(maze: Maze(), room: RoomWithABoom(0), wall: BoomedWall(), door: Door())
        let maze = game.createMaze(factory: prototypeFactory)
        print(maze)
    }
}
