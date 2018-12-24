//
//  Facade.swift
//  DesignPattern
//
//  Created by Trinity on 2018/12/24.
//  Copyright © 2018 BaiYiYuan. All rights reserved.
//

import Foundation

class Parser {
    func parse(scanner: Scanner, programNodeBuilder: ProgramNodeBuilder) {
    }
}

class ProgramNodeBuilder {
    func newVariable(_ variableName: String) -> ProgramNode {
        return ProgramNode()
    }
    
    func newAssignment(variable: ProgramNode, expresion: ProgramNode) -> ProgramNode {
        return ProgramNode()
    }
    
    func newReturnStatement(_ value: ProgramNode) -> ProgramNode {
        return ProgramNode()
    }
    
    func newCondition(condition: ProgramNode, true: ProgramNode, false: ProgramNode) -> ProgramNode {
        return ProgramNode()
    }

    func getRootNode() -> ProgramNode {
        return ProgramNode()
    }
}

class ProgramNode {
    func getSourcePosition() -> (Int, Int) {
        return (-1, -1)
    }
    
    func add(_ node: ProgramNode) {
    }
    
    func remove(_ node: ProgramNode) {
    }
    
    func traverse(_ codeGenerator: CodeGenerator) {
    }
}

class CodeGenerator {
    var output: FileHandle
    
    init(output: FileHandle = .standardOutput) {
        self.output = output
    }
    
    func visit(_ statement: StatementNode) {
    }
    
    func visit(_ expresion: ExpressionNode) {
    }
}

class ExpressionNode: ProgramNode {
    override func traverse(_ codeGenerator: CodeGenerator) {
        codeGenerator.visit(self)
    }
}

class RISCCodeGenerator: CodeGenerator {
}

class Compiler {
    func compile(input: FileHandle, output: FileHandle) {
        let scanner = Scanner(string: String(data: input.availableData, encoding: .utf8) ?? "")
        let builder = ProgramNodeBuilder()
        let parser = Parser()
        parser.parse(scanner: scanner, programNodeBuilder: builder)
        
        let generator = RISCCodeGenerator()
        let parseTree = builder.getRootNode()
        parseTree.traverse(generator)
    }
}

class StatementNode: ProgramNode {
}

struct FacadeRoutine: Routine {
    static func perform() {
    }
}
