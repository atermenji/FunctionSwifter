//
//  Functor.swift
//  FunctionSwifter
//
//  Created by Artur Termenji on 6/12/14.
//

/// This class provides an abstract wrapper for Swift function
class F<T1, T2> {
    
    let f: T1 -> T2
    
    init(function: T1 -> T2) {
        self.f = function
    }
    
    func run(args: T1) -> T2 {
        return f(args)
    }
    
    /// Repeat a function call multiple times
    func repeat(args: T1, times: Int) -> T2 {
        for i in 1..times {
            f(args)
        }
        return f(args)
    }
    
    /// Retry a function call until condition is met or maxTries calls are performed
    func retry(args: T1, maxTries: Int, condition: () -> Bool) -> T2 {
        var tries = 0
        var result: T2?
        
        while !condition() && tries < maxTries {
            result = f(args)
            tries++
        }
        
        return result!
    }
}

/**
* '+' operator overload which accepts two Functors and composes single function from them.
*
* @param beforeHook (Void) -> (Void) function which will be executed before second function.
*/
func +<T1, T2>(beforeHook: F<(), ()>, function: F<T1, T2>) -> (T1 -> T2) {
    
    func composedFunc(args: T1) -> T2 {
        beforeHook.run()
        return function.run(args)
        
    }
    
    return composedFunc
}

/**
* '+' operator overload which accepts two Functors and composes single function from them.
*
* @param afterHook (T2) -> (Void) function which receives a result of the first 
* function call and will be executed after it.
*/
func +<T1, T2>(function: F<T1, T2>, afterHook: F<T2, ()>) -> (T1 -> T2) {
    
    func composedFunc(args: T1) -> T2 {
        var result = function.run(args)
        afterHook.run(result)
        return result
    }
    
    return composedFunc
}

