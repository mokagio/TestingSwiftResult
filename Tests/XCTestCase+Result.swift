import XCTest

extension XCTestCase {

    func assert<T, E>(
        _ result: Result<T, E>,
        isSuccessWith value: T,
        message: (E) -> String = { "Expected to be a success but got a failure with \($0) "},
        file: StaticString = #filePath,
        line: UInt = #line
    ) where E: Error, T: Equatable {
        switch result {
        case .failure(let error):
            XCTFail(message(error), file: file, line: line)
        case .success(let resultValue):
            XCTAssertEqual(resultValue, value)
        }
    }

    func assert<T, E>(
        _ result: Result<T, E>,
        isFailureWith error: E,
        message: (T) -> String = { "Expected to be a failure but got a success with \($0) "},
        file: StaticString = #filePath,
        line: UInt = #line
    ) where E: Equatable & Error {
        switch result {
        case .failure(let resultError):
            XCTAssertEqual(resultError, error)
        case .success(let value):
            XCTFail(message(value), file: file, line: line)
        }
    }
}
