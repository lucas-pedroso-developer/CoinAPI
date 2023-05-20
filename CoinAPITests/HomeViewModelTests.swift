import XCTest
import PromiseKit
import Foundation
@testable import CoinAPI

class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var mockView: MockHomeView!
    var mockUseCase: MockHomeUseCase!

    override func setUp() {
        super.setUp()
        mockView = MockHomeView()
        mockUseCase = MockHomeUseCase()
        viewModel = HomeViewModel(view: mockView, homeUseCase: mockUseCase)
    }

    override func tearDown() {
        viewModel = nil
        mockView = nil
        mockUseCase = nil
        super.tearDown()
    }
    
    func testGetNumberOfRows_WithExchangesEntity_ShouldReturnCorrectNumberOfRows() {
        let exchangesEntity = getExchangeDataMock()
        viewModel.exchangesEntity = exchangesEntity
        let numberOfRows = viewModel.getNumberOfRows(index: 0)
        XCTAssertEqual(numberOfRows, exchangesEntity.count)
    }

    func testGetNumberOfRows_WithoutExchangesEntity_ShouldReturnZero() {
        viewModel.exchangesEntity = nil
        let numberOfRows = viewModel.getNumberOfRows(index: 0)
        XCTAssertEqual(numberOfRows, 0)
    }

    func testGetExchangeId_WithExchangesEntity_ShouldReturnCorrectExchangeId() {
        let exchangeId = "BINANCE"
        let exchangesEntity = getExchangeDataMock()
        viewModel.exchangesEntity = exchangesEntity
        let retrievedExchangeId = viewModel.getExchangeId(index: 0)
        XCTAssertEqual(retrievedExchangeId, exchangeId)
    }

    func testGetExchangeId_WithoutExchangesEntity_ShouldReturnEmptyString() {
        viewModel.exchangesEntity = nil
        let retrievedExchangeId = viewModel.getExchangeId(index: 0)
        XCTAssertEqual(retrievedExchangeId, "")
    }

    func testGetExchanges_WithSuccessfulPromise_ShouldUpdateExchangesEntityAndReloadTableView() {
        let exchangesEntity = getExchangeDataMock()
        let iconsEntity = getExchangeIconMock()
        let expectation = XCTestExpectation(description: "Exchanges loaded successfully")
        
        viewModel.getExchanges()
        
        XCTAssertTrue(mockView.showLoadingCalled)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            XCTAssertTrue(self.mockView.hideLoadingCalled)
            XCTAssertTrue(self.mockView.reloadTableViewCalled)
            XCTAssertEqual(self.viewModel.exchangesEntity, ExchangesEntity.mapFromIconsData(iconsEntity: iconsEntity, exchangesEntity: exchangesEntity))
            expectation.fulfill()
        }
    }

    func testGetExchanges_WithFailurePromise_ShouldShowError() {
        let expectedErrorMessage = "An error occurred"
        let expectation = XCTestExpectation(description: "Exchanges loaded successfully")
        
        viewModel.getExchanges()

        XCTAssertTrue(mockView.showLoadingCalled)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            XCTAssertTrue(self.mockView.hideLoadingCalled)
            XCTAssertTrue(self.mockView.showErrorCalled)
            XCTAssertEqual(self.mockView.errorMessage, expectedErrorMessage)
            expectation.fulfill()
        }
    }
}

extension HomeViewModelTests {
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

class MockHomeView: HomeViewProtocol {
    var showLoadingCalled = false
    var hideLoadingCalled = false
    var reloadTableViewCalled = false
    var showErrorCalled = false
    var errorMessage: String?

    func showLoading() {
        showLoadingCalled = true
    }

    func hideLoading() {
        hideLoadingCalled = true
    }

    func reloadTableView() {
        reloadTableViewCalled = true
    }

    func showError(message: String) {
        showErrorCalled = true
        errorMessage = message
    }
}

class MockHomeUseCase: HomeUseCaseProtocol {
    func getExchanges(completion: @escaping (Swift.Result<[ExchangesEntity], Error>) -> Void) {}
    
    func getExchangesIcons(completion: @escaping (Swift.Result<[IconsEntity], Error>) -> Void) {}
}

enum MockError: Error {
    case mockError
}
