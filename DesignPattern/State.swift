//
//  State.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/29.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

class TCPConnection {
    private (set) var state: TCPState

    init() {
        state = TCPClosed.shared
    }
    
    func processOctet(_ stream: TCPOctetStream) {
    }
    
    func activeOpen() {
        state.activeOpen(self)
    }
    
    func passiveOpen() {
        state.passiveOpen(self)
    }
    
    func closed() {
        state.closed(self)
    }
    
    func send() {
        state.send(self)
    }
    
    func acknowledge() {
        state.acknowledge(self)
    }
    
    func synchronize() {
        state.synchronize(self)
    }

    func changeState(_ state: TCPState) {
        self.state = state
        print("\(self) change state to \(state)")
    }
}

class TCPOctetStream {
}

class TCPState: NSObject {
    func transmit(_ connection: TCPConnection, stream: TCPOctetStream) {
    }
    
    func activeOpen(_ connection: TCPConnection) {
    }
    
    func passiveOpen(_ connection: TCPConnection) {
    }
    
    func closed(_ connection: TCPConnection) {
    }
    
    func send(_ connection: TCPConnection) {
    }
    
    func acknowledge(_ connection: TCPConnection) {
    }
    
    func synchronize(_ connection: TCPConnection) {
    }
    
    func changeState(_ connection: TCPConnection, state: TCPState) {
        connection.changeState(state)
    }
}

class TCPClosed: TCPState {
    static let shared = TCPClosed()
    
    override func activeOpen(_ connection: TCPConnection) {
        // send SYN, receive SYN, ACK, etc.
        
        changeState(connection, state: TCPEstablished.shared)
    }
    
    override func passiveOpen(_ connection: TCPConnection) {
        changeState(connection, state: TCPListen.shared)
    }
}

class TCPEstablished: TCPState {
    static let shared = TCPEstablished()
    
    override func closed(_ connection: TCPConnection) {
        changeState(connection, state: TCPListen.shared)
    }
    
    override func transmit(_ connection: TCPConnection, stream: TCPOctetStream) {
        connection.processOctet(stream)
    }
}

class TCPListen: TCPState {
    static let shared = TCPListen()
    
    override func send(_ connection: TCPConnection) {
        // send SYN, receive SYN, ACK, etc.
        
        changeState(connection, state: TCPEstablished.shared)
    }
}

struct StateRoutine: Routine {
    static func perform() {
        let connection = TCPConnection()
        connection.activeOpen()
    }
}
