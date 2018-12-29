//
//  Memento.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/29.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

class MoveCommand: Command {
    private (set) var target: Graphic
    private (set) var translation: CGPoint
    var state: ConstraintSolverMemento?
    
    init(_ target: Graphic, translation: CGPoint) {
        self.target = target
        self.translation = translation
    }
    
    override func execute() {
        let memento = ConstraintSolver.shared.createSolverMemento()
        state = memento
        target.move(translation)
        ConstraintSolver.shared.solve()
    }
    
    override func unexecute() {
        guard let state = state else {
            return
        }
        
        ConstraintSolver.shared.setMemento(state)
        ConstraintSolver.shared.solve()
    }
}

class ConstraintSolver {
    static let shared = ConstraintSolver()
    
    private init() {
    }
    
    func solve() {
    }
    
    func addConstraint(strat: Graphic, end: Graphic) {
    }
    
    func removeConstraint(start: Graphic, end: Graphic) {
    }
    
    func createSolverMemento() -> ConstraintSolverMemento {
        return ConstraintSolverMemento()
    }
    
    func setMemento(_ menento: ConstraintSolverMemento) {
    }
}

class ConstraintSolverMemento {
}

struct MementoRoutine: Routine {
    static func perform() {
    }
}
