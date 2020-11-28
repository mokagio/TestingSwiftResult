import XCTest

class EquatableResultTests: XCTestCase {

    struct Foo: Equatable {
        let id: Int
    }

    struct EquatableError: Equatable, Error {
        let message: String
    }

    func testSuccess() {
        let result: Result<Foo, EquatableError> = .success(Foo(id: 123))

        XCTAssertEqual(result, .success(Foo(id: 123)))
    }

    func testFailure() {
        let result: Result<Foo, EquatableError> = .failure(EquatableError(message: "abc"))

        XCTAssertEqual(result, .failure(EquatableError(message: "abc")))
        // To see a failure message, uncomment this assertion
        //XCTAssertEqual(result, .success(Foo(id: 123)))
        //
        // Fails with:
        //
        // XCTAssertEqual failed:
        // ("failure(Tests.EquatableResultTests.EquatableError(message: "abc"))")
        // is not equal to ("success(Tests.EquatableResultTests.Foo(id: 123))")
    }
}
