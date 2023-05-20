import XCTest
import Foundation
@testable import CoinAPI

class HomeUseCaseTests: XCTestCase {
    
    var homeUseCase: HomeUseCase!
    var mockRepository: MockHomeRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockHomeRepository()
        homeUseCase = HomeUseCase(homeRepository: mockRepository)
    }
    
    override func tearDown() {
        homeUseCase = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testGetExchanges_Success() {
        let expectedExchanges: [ExchangesEntity] = []
        
        mockRepository.getExchangesHandler = { completion in
            completion(.success(expectedExchanges))
        }
        
        var actualExchanges: [ExchangesEntity]?
        let expectation = self.expectation(description: "getExchanges")
        
        homeUseCase.getExchanges { result in
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
        // Prepare
        let expectedError: HttpError = .networkError // Defina o erro esperado
        
        mockRepository.getExchangesHandler = { completion in
            completion(.failure(expectedError))
        }
        
        // Execute
        var actualError: HttpError?
        let expectation = self.expectation(description: "getExchanges")
        
        homeUseCase.getExchanges { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                actualError = error
            }
            expectation.fulfill()
        }
        
        // Verify
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(actualError, expectedError)
    }

    
    func testGetExchangesIcons_Success() {
        let expectedIcons: [IconsEntity] = []
        
        mockRepository.getExchangesIconsHandler = { completion in
            completion(.success(expectedIcons))
            //return .success(expectedIcons)
        }
        
        var actualIcons: [IconsEntity]?
        let expectation = self.expectation(description: "getExchangesIcons")
        
        homeUseCase.getExchangesIcons { result in
            switch result {
            case .success(let icons):
                actualIcons = icons
            case .failure(_):
                break
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(actualIcons, expectedIcons)
    }
}

class MockHomeRepository: HomeRepositoryProtocol {
    
    var getExchangesHandler: ((@escaping (Result<[ExchangesEntity], HttpError>) -> Void) -> Void)?
    var getExchangesIconsHandler: ((@escaping (Result<[IconsEntity], HttpError>) -> Void) -> Void)?
    
    func getExchanges(completion: @escaping (Result<[ExchangesEntity], HttpError>) -> Void) {
        if let handler = getExchangesHandler {
            handler(completion)
        }
    }
    
    func getExchangesIcons(completion: @escaping (Result<[IconsEntity], HttpError>) -> Void) {
        if let handler = getExchangesIconsHandler {
            handler(completion)
        }
    }
}
