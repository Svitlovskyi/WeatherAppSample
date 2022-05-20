import XCTest
@testable import NetworkLayer

final class NetworkingTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let networkManager = NetworkManager()
        networkManager.getWeather(inCity: "Moscow", completion: { response, error in
            print(response?.city.country)
        })
    }
}
