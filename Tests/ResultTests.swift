import XCTest

class ResultTests: XCTestCase {

    func testResultSuccess() {
        let result = makeResult(42)

        // Option 1
        switch result {
        case .success(let value):
            XCTAssertEqual(value, 42)
        case .failure(let error):
            XCTFail("Expected to be a .success but got a .failure with \(error)")
        }

        // Option 2
        guard case .success(let value) = result else {
            return XCTFail("Expected to be a .success but got a .failure with \(result)")
        }
        XCTAssertEqual(value, 42)

        // Option 3
        assert(result, isSuccessWith: 42)
    }

    func testResultFailur() {
        let error = TestError()
        let result = makeResult(error)

        // Option 1
        switch result {
        case .success(let value):
            XCTFail("Expected to be a .failure but got a .success with \(value)")
        case .failure(let resultError):
            XCTAssertEqual(resultError, error)
        }

        // Option 2
        guard case .failure(let resultError) = result else {
            return XCTFail("Expected to be a .failure but got a .success with \(result)")
        }
        XCTAssertEqual(resultError, error)

        // Option 3
        assert(result, isFailureWith: error)
    }

    // MARK: -

    func assert<T>(
        _ result: Result<T, Error>,
        isSuccessWith value: T
    ) where T: Equatable {
        switch result {
        case .success(let resultValue):
            XCTAssertEqual(resultValue, value)
        case .failure(let error):
            XCTFail("Expected to be a .success but got a .failure with \(error)")
        }
    }

    func assert<T, E>(
        _ result: Result<T, E>,
        isFailureWith error: E
    ) where E: Equatable & Error {
        switch result {
        case .success(let value):
            XCTFail("Expected to be a .failure but got a .success with \(value)")
        case .failure(let resultError):
            XCTAssertEqual(resultError, error)
        }
    }

    // MARK: -

    // These are just to avoid doing a
    //
    // ```
    // let result = Result<...>.success(...)
    // ```
    //
    // and then get a warning from Xcode:
    //
    // > Switch condition evaluates a constant

    func makeResult<T>(_ value: T) -> Result<T, Error> {
        return .success(value)
    }

    func makeResult<E>(_ error: E) -> Result<Never, E> where E: Error {
        return .failure(error)
    }
}

struct TestError: Equatable, Error {}
