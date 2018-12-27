//
//  Interpreter.swift
//  DesignPattern
//
//  Created by 高炼 on 2018/12/27.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

class Context {
    private lazy var booleanTable = [String: Bool]()
    
    func lookUp(_ variableName: String) throws -> Bool {
        guard let result = booleanTable[variableName] else {
            throw BooleanExpError.variableNotInContext
        }
        
        return result
    }
    
    func assign(_ variable: VariableExp, bool: Bool) {
        booleanTable[variable.name] = bool
    }
}

class BooleanExp {
    enum Error: Swift.Error {
        case variableNotInContext
        case contextError
    }
    
    func evaluate(_ context: Context) throws -> Bool {
        throw Error.variableNotInContext
    }
    
    func copy() -> BooleanExp {
        return BooleanExp()
    }
}

typealias BooleanExpError = BooleanExp.Error

class VariableExp: BooleanExp {
    var name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    override func evaluate(_ context: Context) throws -> Bool {
        guard let result = try? context.lookUp(name) else {
            throw Error.contextError
        }

        return result
    }
    
    override func copy() -> BooleanExp {
        return VariableExp(name)
    }
}

class AndExp: BooleanExp {
    var expression1: BooleanExp
    var expression2: BooleanExp
    
    init(_ expression1: BooleanExp, _ expression2: BooleanExp) {
        self.expression1 = expression1
        self.expression2 = expression2
    }
    
    override func evaluate(_ context: Context) throws -> Bool {
        return try expression1.evaluate(context) && expression2.evaluate(context)
    }
    
    override func copy() -> BooleanExp {
        return AndExp(expression1.copy(), expression2.copy())
    }
}

class OrExp: BooleanExp {
    var expression1: BooleanExp
    var expression2: BooleanExp
    
    init(_ expression1: BooleanExp, _ expression2: BooleanExp) {
        self.expression1 = expression1
        self.expression2 = expression2
    }
    
    override func evaluate(_ context: Context) throws -> Bool {
        return try expression1.evaluate(context) || expression2.evaluate(context)
    }
    
    override func copy() -> BooleanExp {
        return OrExp(expression1.copy(), expression2.copy())
    }
}

class Constant: BooleanExp {
    private var value: Bool
    
    init(_ value: Bool) {
        self.value = value
    }
    
    override func evaluate(_ context: Context) throws -> Bool {
        return value
    }
    
    override func copy() -> BooleanExp {
        return Constant(value)
    }
}

class NotExp: BooleanExp {
    var expression: BooleanExp
    
    init(_ expression: BooleanExp) {
        self.expression = expression
    }
    
    override func evaluate(_ context: Context) throws -> Bool {
        return try !expression.evaluate(context)
    }
}

struct InterpreterRoutine: Routine {
    static func perform() {
        let context = Context()
        
        let x = VariableExp("x")
        let y = VariableExp("y")
        
        context.assign(x, bool: true)
        context.assign(y, bool: false)
        
        let notX = NotExp(x)
        let expression = AndExp(y, notX)
        
        do {
            try print(expression.evaluate(context))
        } catch {
            print(error)
        }
    }
}
