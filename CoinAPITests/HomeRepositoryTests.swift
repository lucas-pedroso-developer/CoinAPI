import XCTest
import Foundation
@testable import CoinAPI

class HomeRepositoryTests: XCTestCase {
    
    func testGetExchanges_Success() {
        
        let expectedExchanges: [ExchangesEntity] = getExchangeDataMock()
        let mockNetworkClient = MockHttpGetClient()
        mockNetworkClient.result = .success(Data())
        mockNetworkClient.json = getExchangesDataJSON()
        let homeRepository = HomeRepository(network: mockNetworkClient)
        
        var actualExchanges: [ExchangesEntity]?
        let expectation = self.expectation(description: "getExchanges")
        
        homeRepository.getExchanges { result in
            switch result {
            case .success(let exchanges):
                actualExchanges = exchanges
            case .failure(_):
                break
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(actualExchanges, expectedExchanges)
    }
    
    func testGetExchanges_Failure() {
        
        let expectedError: HttpError = .decodeError
        let mockNetworkClient = MockHttpGetClient()
        mockNetworkClient.result = .failure(expectedError)
        let homeRepository = HomeRepository(network: mockNetworkClient)
        
        var actualError: HttpError?
        let expectation = self.expectation(description: "getExchanges")
        
        homeRepository.getExchanges { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                actualError = error
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(actualError, expectedError)
    }
    
    func testGetExchangesIcons_Success() {
        
        let expectedIcons: [IconsEntity] = getExchangeIconMock()
        let mockNetworkClient = MockHttpGetClient()
        mockNetworkClient.result = .success(Data())
        mockNetworkClient.json = getExchangesIconJSON()
        let homeRepository = HomeRepository(network: mockNetworkClient)
        
        var actualIcons: [IconsEntity]?
        let expectation = self.expectation(description: "getExchangesIcons")
        
        homeRepository.getExchangesIcons { result in
            switch result {
            case .success(let icons):
                actualIcons = icons
            case .failure(_):
                break
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
        XCTAssertEqual(actualIcons, expectedIcons)
    }
    
    func testGetExchangesIcons_Failure() {
        let expectedError: HttpError = .decodeError
        let mockNetworkClient = MockHttpGetClient()
        mockNetworkClient.result = .failure(expectedError)
        let homeRepository = HomeRepository(network: mockNetworkClient)
        var actualError: HttpError?
        let expectation = self.expectation(description: "getExchangesIcons")
        
        homeRepository.getExchangesIcons { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                actualError = error
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
        XCTAssertEqual(actualError, expectedError)
    }
}

extension HomeRepositoryTests {
    func getExchangeDataMock() -> [ExchangesEntity] {
        let JSON = getExchangesDataJSON()
        let jsonData = JSON.data(using: .utf8)!
        return try! JSONDecoder().decode([ExchangesEntity].self, from: jsonData)
    }
    
    func getExchangeIconMock() -> [IconsEntity] {
        let JSON = getExchangesDataJSON()
        let jsonData = JSON.data(using: .utf8)!
        return try! JSONDecoder().decode([IconsEntity].self, from: jsonData)
    }
}

class MockHttpGetClient: HttpGetClient {
    
    var result: Result<Data?, HttpError>?
    var requestedURL: URL?
    var json: String = ""
    func get(url: URL?, completion: @escaping (Swift.Result<Data?, HttpError>) -> Void) {
        requestedURL = url
        
        if let jsonData = json.data(using: .utf8) {
            completion(.success(jsonData))
        } else {
            completion(.failure(.networkError))
        }
    }
}
