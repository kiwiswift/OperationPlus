//
//  AsyncConsumerProducerOperation.swift
//  OperationPlus
//
//  Created by Matt Massicotte on 2019-09-13.
//  Copyright © 2019 Chime Systems Inc. All rights reserved.
//

import Foundation

/// An asynchronous variant of ConsumerProducerOperation
open class AsyncConsumerProducerOperation<Input, Output>: ConsumerProducerOperation<Input, Output> {
    override open var isAsynchronous: Bool {
        return true
    }
}

open class AsyncConsumerResultOperation<Input, Output, Failure>: AsyncConsumerProducerOperation<Result<Input, Failure>, Result<Output, Failure>> where Failure: Error {
    
    override open func main() {
        guard let producerResult = producerValue, checkForCancellation() else {
            self.finish()
            return
        }
        switch producerResult {
        case let .success(value): self.execute(with: value)
        case let .failure(error): self.finish(with: error)
        }
    }
    
    open func execute(with value: Input) {
        fatalError("Must be implemented")
    }
}
