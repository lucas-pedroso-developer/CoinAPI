import XCTest
@testable import CoinAPI

class HomeViewControllerTests: XCTestCase {
    
    var viewController: HomeViewController!
    var coordinatorMock: AppCoordinatorMock!
    var viewModelMock: HomeViewModelProtocolMock!
    var tableViewMock: UITableViewMock!
    var loaderViewControllerMock: LoadingViewControllerMock!
    
    override func setUp() {
        super.setUp()
        viewController = HomeViewController()
        coordinatorMock = AppCoordinatorMock(window: UIWindow(frame: UIScreen.main.bounds))
        viewModelMock = HomeViewModelProtocolMock()
        tableViewMock = UITableViewMock()
        loaderViewControllerMock = LoadingViewControllerMock()
        
        viewController.coordinator = coordinatorMock
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
}

class AppCoordinatorMock: AppCoordinator {
    var didCallShowDetails = false
    var exchangeEntity: ExchangesEntity?
    
    override func showDetails(exchangeEntity: ExchangesEntity?) {
        didCallShowDetails = true
        self.exchangeEntity = exchangeEntity
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
