import XCTest

extension XCTestCase {

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
}
