FunctionSwifter is a simple playground for composing Swift functions.

It introduces a ```Functor``` class, which wraps a function and provides some basic operations to compose functions.

```swift
func logger(text: String) {
    println("LOG: \(text)")
}

loggerFunc = F(logger)
loggerFunc.run("hello")
```

## Usage
### Composing functions with '+' operator

```swift
func logger(text: String) {
    println("LOG: \(text)")
}

func request(url: String) -> String {
    return "Success 200"
}

let logRequest = F(request) + F(logger)
logRequest("http://some.awesome.url") // => "LOG: Success 200"
```

### Repeating function calls

```swift
func greeting(firstName: String, lastName: String) {
    print("Hello, " + firstName + " " + lastName + "!")
}

F(greeting).repeat(("John", "Doe"), times: 3) // => Hello, John Doe! Hello, John Doe! Hello, John Doe!
```
### Composing functions without '+' operator
This repo also includes ```Swifter``` class which provides a way to compose functions without using ```+``` operator:

```swift
let composedRequest = Before(request).run({ println("Request is fired!") })
let loggedRequest = After(request).run(logger)
```

You can find all the samples in ```main.swift``` file.


