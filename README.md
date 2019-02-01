[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Build Status](https://travis-ci.org/ChimeHQ/OperationPlus.svg?branch=master)](https://travis-ci.org/ChimeHQ/OperationPlus)

# OperationPlus

OperationPlus is a small set of NSOperation subclasses and extensions on NSOperation/NSOperationQueue. Its goal is to fill in NSOperation API's missing pieces. You don't need to learn anything new to use it.

There are a bunch of alternatives to the NSOperation model, like reactive programming. But, since Apple ships NSOperation, it gets used a lot. Once you start building real applications against it, you might find that the API is missing some important parts. OperationPlus tries to fill those in.

## Installation

Carthage:

```
    github "ChimeHQ/OperationPlus"
```

## NSOperation Subclasses

**BaseOperation**

This is a simple `NSOperation` subclass built for easier extensibility. It features:

 - Thread-safety
 - Timeout support
 - Easier cancellation handling
 - Stricter state checking

**AsyncOperation**

A `BaseOperation` subclass that can be used for your asynchronous operations. These are any operations that need to extend their lifetime past the `main` method.

**ResultOperation**

A `BaseOperation` subclass that yields a value. Includes a completion handler to access the value.

**AsyncResultOperation**

A variant of `ResultOperation` that may produce a result value after the `main` method has completed executing.

**AsyncBlockOperation**

A play on `NSBlockOperation`, but makes it possive to support asynchronous completion without making an NSOperation subclass.

## NSOperation/NSOperationQueue Extensions

Queue creation conveniences:

```
  let a = OperationQueue(name: "myqueue")
  let b = OperationQueue(name: "myqueue", maxConcurrentOperations: 1)
  let c = OperationQueue.serialQueue()
  let d = OperationQueue.serialQueue(named: "myqueue")
```

Enforcing runtime constraints on queue execution:

```
    OperationQueue.preconditionMain()
    OperationQueue.preconditionNotMain()
```

Consise dependencies:

```
    queue.addOperation(op, dependency: opA)
    queue.addOperation(op, dependencies: [opA, opB])
    
    op.addDependencies([opA, opB])
```

Queueing work when a queue's current operations are complete:

```
    queue.currentOperationsFinished {
      print("all pending ops done")
    }
```

### XCTest Support

**OperationTestingPlus** is an optional micro-framework to help make your XCTest-based tests a little nicer.

**FulfillExpectationOperation**

A simple NSOperation that will fulfil an `XCTestExpectation` when complete. Super-useful when used setup with dependencies on your other operations.

**NeverFinishingOperation**

A great way to test out your Operations' timeout behaviors.

**OperationExpectation**

An `XCTestExpectation` sublass to make testing async operations a little more XCTTest-like.

```
    let op = NeverFinishingOperation()

    let expectation = OperationExpectation(operation: op)
    expectation.isInverted = true

    wait(for: [expectation], timeout: 1.0)
```

### Suggestions or Feedback

We'd love to hear from you! Get in touch via [twitter](https://twitter.com/chimehq), an issue, or a pull request.

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.
