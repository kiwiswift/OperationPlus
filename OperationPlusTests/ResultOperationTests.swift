//
//  ResultOperationTests.swift
//  OperationPlusTests
//
//  Created by Christiano Gontijo on 6/02/20.
//  Copyright © 2020 Chime Systems Inc. All rights reserved.
//

import XCTest
import OperationTestingPlus
@testable import OperationPlus

class MockResultOperation: ProducerOperation<Result<Int?, Error>> {
    
    let intValue: Int?
    
    init(intValue: Int?) {
        self.intValue = intValue
    }
    
    override func main() {
        if intValue == 0 {
            let error = NSError(domain: "Test", code: 6, userInfo: nil)
            finish(with: error)
        } else {
            finish(with: intValue)
        }
    }
}


class ResultOperationTests: XCTestCase {

    func testResultSuccess() throws {
        let op = MockResultOperation(intValue: 6)

        let expectation = OperationExpectation(operation: op)

        wait(for: [expectation], timeout: 1.0)

        XCTAssertTrue(op.isFinished)
        XCTAssertEqual(try op.value?.get(), 6)
    }
    
    func testResultSuccessWithNilValue() throws {
        let op = MockResultOperation(intValue: nil)

        let expectation = OperationExpectation(operation: op)

        wait(for: [expectation], timeout: 1.0)

        XCTAssertTrue(op.isFinished)
        XCTAssertEqual(try op.value?.get(), nil)
    }
    
    func testResultFailed() throws {
        let op = MockResultOperation(intValue: 0)

        let expectation = OperationExpectation(operation: op)

        wait(for: [expectation], timeout: 1.0)

        XCTAssertTrue(op.isFinished)
        XCTAssertThrowsError(try op.value?.get())
    }

}
