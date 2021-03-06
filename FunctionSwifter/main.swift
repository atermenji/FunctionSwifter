//
//  main.swift
//  FunctionSwifter
//
//  Created by Artur Termenji on 6/12/14.
//

/**
* Usage sample
*/

import Foundation

func hello() {
    println("Hello, World!")
}

func logger(text: String) {
    println("LOG: \(text)")
}

func request(url: String) -> String {
    return "Success 200"
}

println("\n=== Composing functions ====\n")

let composedRequest = F(hello) + F(request)
println(composedRequest("http://some.awesome.url") + "\n")

let logRequest = F(request) + F(logger)
logRequest("http://some.awesome.url")

println("\n=== Composing without '+' operator ===\n")

let printRequest = Before(request).run({ println("Request is fired!") })
println(printRequest("http://some.awesome.url") + "\n")

let loggedRequest = After(request).run(logger)
loggedRequest("http://some.awesome.url")

println("\n=== Calling function several times ===\n")

func greeting(firstName: String, lastName: String) {
    print("Hello, " + firstName + " " + lastName + "!")
}

F(greeting).repeat(("John", "Doe"), times: 3)

var requestResult: Int = 0
func randomRequest(url: String) {
    let result = Int(arc4random_uniform(UInt32(2)))

    if result > 0 {
        requestResult = 200
    } else {
        requestResult = 404
    }
}

F(randomRequest).retry("http://some.awesome.url", maxTries: 5, condition: { requestResult == 200 })