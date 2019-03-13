//
//  AbstractFactory.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/6.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

class MapSite: Copyable, CustomStringConvertible {
    func enter() { }
    
    func clone() -> Self {
        return cast(MapSite())
    }
    
    var description: String {
        return "\(Mirror(reflecting: self).subjectType)"
    }
}

class Room: MapSite {
    enum Side: Int{
        case north
        case south
        case east
        case west
    }
    
    var roomNo: Int
    
    init(_ roomNo: Int) {
        self.roomNo = roomNo
    }
    
    private var sides = [MapSite?](repeating: nil, count: 4)
    
    func setSide(_ side: Side, mapSite: MapSite?) {
        sides[side.rawValue] = mapSite
    }
    
    func mapSite(at side: Side) -> MapSite? {
        return sides[side.rawValue]
    }
    
    override func clone() -> Self {
        return cast(Room(roomNo))
    }
    
    override var description: String {
        return "\(Mirror(reflecting: self).subjectType)<\(roomNo)>"
    }
}

class Wall: MapSite {
    override func clone() -> Self {
        return cast(Wall())
    }
}

class Door: MapSite {
    var room1: Room?
    var room2: Room?
    
    init(room1: Room? = nil, room2: Room? = nil) {
        self.room1 = room1
        self.room2 = room2
    }
    
    func otherSideFrom(side: Room?) -> Room? {
        guard let side = side else { return nil }
        if side === room1 {
            return room2
        } else if side === room2 {
            return room1
        } else {
            return nil
        }
    }
    
    override func clone() -> Self {
        return cast(Door(room1: room1, room2: room2))
    }
    
    override var description: String {
        return "\(super.description)<\(room1?.roomNo.description ?? "_"), \(room2?.roomNo.description ?? "_")>"
    }
}

class Maze: Copyable, CustomStringConvertible {
    private var rooms = [Int: Room]()
    
    func addRoom(_ room: Room) {
        rooms[room.roomNo] = room
    }
    
    func room(ofNo no: Int) -> Room? {
        return rooms[no]
    }
    
    func clone() -> Self {
        let maze = Maze()
        maze.rooms = rooms
        return cast(maze)
    }
    
    var description: String {
        return "\(Mirror(reflecting: self).subjectType): \(rooms)"
    }
}

class MazeFactory: NSObject {
    private (set) static var shared = MazeFactory()

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

class MazeGame {
    func createMaze(factory: MazeFactory) -> Maze {
        let maze = factory.makeMaze()
        let room1 = factory.makeRoom(withNo: 1)
        let room2 = factory.makeRoom(withNo: 2)
        let door = factory.makeDoor(room1: room1, room2: room2)
        
        maze.addRoom(room1)
        maze.addRoom(room2)
        
        room1.setSide(.north, mapSite: factory.makeWall())
        room1.setSide(.east, mapSite: door)
        room1.setSide(.south, mapSite: factory.makeWall())
        room1.setSide(.west, mapSite: factory.makeWall())
        room1.setSide(.north, mapSite: factory.makeWall())
        room1.setSide(.east, mapSite: factory.makeWall())
        room1.setSide(.west, mapSite: factory.makeWall())
        room1.setSide(.west, mapSite: door)
        
        return maze
    }
    
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

class Spell {
}

class EnchantRoom: Room {
    private (set) var spell: Spell
    
    init(_ roomNo: Int, spell: Spell) {
        self.spell = spell
        super.init(roomNo)
    }
}

class DoorNeedingSpell: Door {
    override func clone() -> Self {
        return cast(DoorNeedingSpell(room1: room1, room2: room2))
    }
}

class EnchantMazeFactory: MazeFactory {
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

class RoomWithABoom: Room {
    override func clone() -> Self {
        return cast(RoomWithABoom(roomNo))
    }
}

class BombedWall: Wall {
    override func clone() -> Self {
        return cast(BombedWall())
    }
}

class BombedMazeFactory: MazeFactory {
    override func makeWall() -> Wall {
        return BombedWall()
    }
    
    override func makeRoom(withNo no: Int) -> Room {
        return RoomWithABoom(no)
    }
}

struct AbstractFactoryRoutine: Routine {
    static func perform() {
        let game = MazeGame()
        let factory = MazeFactory()
        let maze = game.createMaze(factory: factory)
        print(maze)
    }
}
