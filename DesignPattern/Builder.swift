//
//  Builder.swift
//  DesignPattern
//
//  Created by Trinity on 2018/12/16.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

class MazeBuilder {
    func buildMaze() {
    }
    
    func buildRoom(ofNo no: Int) {
    }
    
    func buildDoor(noOfRoom1 no1: Int, noOfRoom1 no2: Int) {
    }
    
    func getMaze() -> Maze! {
        return nil
    }
}

extension MazeGame {
    @discardableResult
    func createMaze(builder: MazeBuilder) -> Maze! {
        builder.buildMaze()
        
        builder.buildRoom(ofNo: 1)
        builder.buildRoom(ofNo: 2)
        builder.buildDoor(noOfRoom1: 1, noOfRoom1: 2)
        
        return builder.getMaze()
    }
}

class StandardMazeBuilder: MazeBuilder {
    private var currentMaze: Maze!
    
    func commonWall(betweenRoom1 room1: Room, andRoom2 room2: Room) -> Room.Side {
        if room1.roomNo < room2.roomNo {
            return Room.Side.east
        } else {
            return Room.Side.west
        }
    }
    
    override func buildMaze() {
        currentMaze = Maze()
    }
    
    override func buildRoom(ofNo no: Int) {
        let room = Room(no)
        
        room.setSide(.north, mapSite: Wall())
        room.setSide(.south, mapSite: Wall())
        room.setSide(.east, mapSite: Wall())
        room.setSide(.west, mapSite: Wall())
        
        currentMaze.addRoom(room)
    }
    
    override func buildDoor(noOfRoom1 no1: Int, noOfRoom1 no2: Int) {
        let room1 = currentMaze.room(ofNo: no1)!
        let room2 = currentMaze.room(ofNo: no2)!
        
        let door = Door(room1: room1, room2: room2)
        
        room1.setSide(commonWall(betweenRoom1: room1, andRoom2: room2), mapSite: door)
        room2.setSide(commonWall(betweenRoom1: room2, andRoom2: room1), mapSite: door)
    }

    override func getMaze() -> Maze {
        return currentMaze
    }
}

class CountingMazeBuilder: MazeBuilder {
    private var doorCount: Int = 0
    private var roomCount: Int = 0
    
    override func buildMaze() {
        doorCount = 0
        roomCount = 0
    }
    
    override func buildDoor(noOfRoom1 no1: Int, noOfRoom1 no2: Int) {
        doorCount += 1
    }
    
    override func buildRoom(ofNo no: Int) {
        roomCount += 1
    }
    
    typealias Count = (room: Int, door: Int)
    
    func getCount() -> Count {
        return (roomCount, doorCount)
    }
}

struct BuilderRoutine: Routine {
    static func perform() {
        let game = MazeGame()
        
        let builder = StandardMazeBuilder()
        let countBuilder = CountingMazeBuilder()
        
        let maze: Maze = game.createMaze(builder: builder)
        game.createMaze(builder: countBuilder)
        
        let count = countBuilder.getCount()

        print("\(maze) with \(count.room) rooms, and \(count.door) doors.")
    }
}
