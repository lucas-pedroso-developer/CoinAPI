import XCTest
@testable import CoinAPI

class HomeViewControllerTests: XCTestCase {
    
    var viewController: HomeViewController!
    var coordinatorMock: DetailCoordinatorMock!
    var viewModelMock: HomeViewModelProtocolMock!
    var tableViewMock: UITableViewMock!
    var loaderViewControllerMock: LoadingViewControllerMock!
    
    override func setUp() {
        super.setUp()
        viewController = HomeViewController()
        coordinatorMock = DetailCoordinatorMock(navigationController: viewController.navigationController ?? UINavigationController(), exchange: getSelectedExchange(index: 0))
        viewModelMock = HomeViewModelProtocolMock()
        tableViewMock = UITableViewMock()
        loaderViewControllerMock = LoadingViewControllerMock()
        
        viewController.detailCoordinator = coordinatorMock
        viewController.viewModel = viewModelMock
        viewController.tableView = tableViewMock
        viewController.loaderViewController = loaderViewControllerMock
    }
    
    override func tearDown() {
        viewController = nil
        coordinatorMock = nil
        viewModelMock = nil
        tableViewMock = nil
        loaderViewControllerMock = nil
        super.tearDown()
    }
    
    private func getSelectedExchange(index: Int) -> ExchangesEntity {
        return ExchangesEntity(exchangeId: "", website: "", name: "", dataStart: "", dataEnd: "", dataQuoteStart: "", dataQuoteEnd: "", dataOrderbookStart: "", dataOrderbookEnd: "", dataTradeStart: "", dataTradeEnd: "", dataSymbolsCount: 0, volume1hrsUsd: 0.0, volume1dayUsd: 0.0, volume1mthUsd: 0.0, icon: "")
    }
    
    func testViewDidLoad() {
        viewController.viewDidLoad()
        XCTAssertEqual(viewController.title, Constants.title.rawValue)
    }
    
    func testGetExchanges() {
        viewController.getExchanges()
        XCTAssertTrue(viewModelMock.didCallGetExchanges)
    }
    
    func testReloadTableView() {
        viewController.reloadTableView()
        XCTAssertTrue(tableViewMock.reloadDataCalled)
    }
    
    func testShowLoading() {
        viewController.showLoading()
        XCTAssertTrue(loaderViewControllerMock.startLoadingCalled)
    }
    
    func testHideLoading() {
        viewController.hideLoading()
        XCTAssertTrue(loaderViewControllerMock.stopLoadingCalled)
    }
    
    func testDidTapRefresh() {
        viewController.didTapRefresh()
        XCTAssertTrue(viewModelMock.didCallGetExchanges)
    }
    
    func testDetailCoordinatorCallShowDetails() {
        coordinatorMock.start()
        XCTAssertTrue(coordinatorMock.didCallShowDetails)
    }
}

class DetailCoordinatorMock: DetailCoordinator {
    var didCallShowDetails = false
    var exchangeEntity: ExchangesEntity?
    
    override func start() {
        didCallShowDetails = true
    }
}

class HomeViewModelProtocolMock: HomeViewModelProtocol {
    
    var exchangeId: String = ""
    var exchangeName: String = ""
    var volumeDayOne: Double = 0.0
    var icon: String = ""
    var didCallGetExchanges = false
    
    func getExchanges() {
        didCallGetExchanges = true
    }
    
    func getNumberOfRows(index: Int) -> Int {
        return 0
    }
    
    func getExchangeId(index: Int) -> String {
        return exchangeId
    }
    
    func getExchangeName(index: Int) -> String {
        return exchangeName
    }
    
    func getVolumeDayOne(index: Int) -> Double {
        return volumeDayOne
    }
    
    func getIcon(index: Int) -> String {
        return icon
    }
    
    func getSelectedExchange(index: Int) -> ExchangesEntity? {
        return nil
    }
}

class UITableViewMock: UITableView {
    var reloadDataCalled = false
    
    override func reloadData() {
        reloadDataCalled = true
    }
}

class LoadingViewControllerMock: LoadingViewController {
    var startLoadingCalled = false
    var stopLoadingCalled = false
    
    override func startLoading() {
        startLoadingCalled = true
    }
    
    override func stopLoading() {
        stopLoadingCalled = true
    }
}
