//
//  Result+Extensions.swift
//  OperationPlus
//
//  Created by Christiano Gontijo on 6/02/20.
//  Copyright © 2020 Chime Systems Inc. All rights reserved.
//

protocol ResultConformance {
    associatedtype Success
    associatedtype Failure: Error
    init(value: Success)
    init(error: Failure)
}

extension Result: ResultConformance {
    /// Constructs a success wrapping a `value`.
    init(value: Success) {
        self = .success(value)
    }

    /// Constructs a failure wrapping an `error`.
    init(error: Failure) {
        self = .failure(error)
    }
}

