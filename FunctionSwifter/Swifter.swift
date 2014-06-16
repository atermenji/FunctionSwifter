//
//  Swifter.swift
//  FunctionSwifter
//
//  Created by Artur Termenji on 6/13/14.
//

/**
* A class which allows to compose two functions by passing a closure,
* which will be executed before main function.
*/
class Before<T1, T2> {
    
    let f: F<T1, T2>
    
    init(function: T1 -> T2) {
        self.f = F(function)
    }
    
    func run(beforeHook: () -> ()) -> (T1 -> T2) {
        
        func composedFunction(args: T1) -> T2 {
            beforeHook()
            return f.run(args)
        }
        
        return composedFunction
    }
}

/**
* A class which allows to compose two functions by passing a function,
* which will be executed after main function with result of calling main function.
*/
class After<T1, T2> {
    
    let f: F<T1, T2>
    
    init(function: T1 -> T2) {
        self.f = F(function)
    }
    
    func run(afterHook: T2 -> ()) -> (T1 -> T2) {
        
        func composedFunction(args: T1) -> T2 {
            var result = f.run(args)
            afterHook(result)
            return result
        }
        
        return composedFunction
    }
}