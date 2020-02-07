//
//  Result+Extensions.swift
//  OperationPlus
//
//  Created by Christiano Gontijo on 6/02/20.
//  Copyright © 2020 Chime Systems Inc. All rights reserved.
//

public protocol ResultConformance {
    associatedtype Success
    associatedtype Failure: Error
    init(value: Success)
    init(error: Failure)
}

extension Result: ResultConformance {
    /// Constructs a success wrapping a `value`.
    public init(value: Success) {
        self = .success(value)
    }

    /// Constructs a failure wrapping an `error`.
    public init(error: Failure) {
        self = .failure(error)
    }
}

