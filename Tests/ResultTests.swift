import XCTest

class ResultTests: XCTestCase {

    func testResultSuccessGet() throws {
        let result = Result<Int, Error>.success(42)

        let value = try result.get()

        XCTAssertEqual(value, 42)
    }

    func testResultSuccessExampleGuard() {
        let result = Result<Int, Error>.success(42)

        guard case .success(let value) = result else {
            return XCTFail("Expected to be a success but got a failure with \(result)")
        }
        XCTAssertEqual(value, 42)
    }

    func testResultSuccessExampleSwitch() throws {
        // Wrapped in closure to avoid warning about switch condition on a constant.
        let result = { Result<Int, Error>.success(42) }()

        switch result {
        case .success(let value):
            XCTAssertEqual(value, 42)
        case .failure(let error):
            XCTFail("Expected to be a success but got a failure with \(error)")
        }

        assert(result, isSuccessWith: 42)
    }

    func testResultSuccessWithHelper() {
        let result = Result<Int, TestError>.success(42)

        assert(result, isSuccessWith: 42)
        assert(result, isSuccessWith: 42, message: { "Failed with '\($0.message)'" })
    }

    func testResultFailureGuard() {
        let expectedError = TestError()
        let result = Result<Never, TestError>.failure(expectedError)

        guard case .failure(let error) = result else {
            return XCTFail("Expected to be a failure but got a success with \(result)")
        }
        XCTAssertEqual(error, expectedError)
    }

    func testResultFailureSwitch() {
        let expectedError = TestError()
        // Wrapped in closure to avoid warning about switch condition on a constant.
        let result = { Result<Never, TestError>.failure(expectedError) }()

        switch result {
        case .success(let value):
            XCTFail("Expected to be a failure but got a success with \(value)")
        case .failure(let error):
            XCTAssertEqual(error, expectedError)
        }
    }

    func testResultFailureWithHelper() {
        let result = Result<Int, TestError>.failure(TestError(message: "abc"))

        assert(result, isFailureWith: TestError(message: "abc"))
        assert(result, isFailureWith: TestError(message: "abc"), message: { "Succeeded with '\($0)'" })
    }
}

struct TestError: Equatable, Error {
    private(set) var message: String = "unknown"
}
