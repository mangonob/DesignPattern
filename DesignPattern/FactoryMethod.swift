//
//  FactoryMethod.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/6.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

extension MazeGame {
    func createMaze() -> Maze {
        let maze = makeMaze()
        let room1 = makeRoom(withNo: 1)
        let room2 = makeRoom(withNo: 2)
        let door = makeDoor(room1: room1, room2: room2)
        
        maze.addRoom(room1)
        maze.addRoom(room2)
        
        room1.setSide(.north, mapSite: makeWall())
        room1.setSide(.east, mapSite: door)
        room1.setSide(.south, mapSite: makeWall())
        room1.setSide(.west, mapSite: makeWall())
        room1.setSide(.north, mapSite: makeWall())
        room1.setSide(.east, mapSite: makeWall())
        room1.setSide(.west, mapSite: makeWall())
        room1.setSide(.west, mapSite: door)
        
        return maze
    }
    
    func makeMaze() -> Maze {
        return Maze()
    }
    
    func makeWall() -> Wall {
        return Wall()
    }
    
    func makeRoom(withNo no: Int) -> Room {
        return Room(no)
    }
    
    func makeDoor(room1: Room?, room2: Room?) -> Door {
        return Door(room1: room1, room2: room2)
    }
}

class FactoryMethodRoutine: Routine {
    static func perform() {
        print(MazeGame().createMaze())
    }
}
