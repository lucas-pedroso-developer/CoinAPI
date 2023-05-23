import XCTest
@testable import CoinAPI

class HomeViewControllerTests: XCTestCase {
    
    var sut: HomeViewController!
    var coordinatorMock: DetailCoordinatorMock!
    var viewModelMock: HomeViewModelProtocolMock!
    
    override func setUp() {
        super.setUp()
        sut = HomeViewController()
        sut.setupViews()
        coordinatorMock = DetailCoordinatorMock(navigationController: sut.navigationController ?? UINavigationController(), exchange: getSelectedExchange(index: 0))
        viewModelMock = HomeViewModelProtocolMock()
        sut.detailCoordinator = coordinatorMock
        sut.viewModel = viewModelMock
    }
    
    override func tearDown() {
        sut = nil
        coordinatorMock = nil
        viewModelMock = nil
        super.tearDown()
    }
    
    private func getSelectedExchange(index: Int) -> ExchangesEntity {
        return ExchangesEntity(exchangeId: "", website: "", name: "", dataStart: "", dataEnd: "", dataQuoteStart: "", dataQuoteEnd: "", dataOrderbookStart: "", dataOrderbookEnd: "", dataTradeStart: "", dataTradeEnd: "", dataSymbolsCount: 0, volume1hrsUsd: 0.0, volume1dayUsd: 0.0, volume1mthUsd: 0.0, icon: "")
    }
    
    func testViewDidLoad() {
        sut.viewDidLoad()
        XCTAssertEqual(sut.title, Constants.title.rawValue)
    }
    
    func testGetExchanges() {
        sut.getExchanges()
        XCTAssertTrue(viewModelMock.didCallGetExchanges)
    }
    
    func testDidTapRefresh() {
        sut.didTapRefresh()
        XCTAssertTrue(viewModelMock.didCallGetExchanges)
    }
    
    func testDetailCoordinatorCallShowDetails() {
        coordinatorMock.start()
        XCTAssertTrue(coordinatorMock.didCallShowDetails)
    }
    
    func testTableViewComponent_Configuration() {
        XCTAssertNotNil(sut.tableViewComponent)
        XCTAssertNotNil(sut.tableViewComponent.dataSource)
        XCTAssertNotNil(sut.tableViewComponent.delegate)
        XCTAssertTrue(sut.tableViewComponent.backgroundColor == .clear)
    }
    
    func testLoaderComponent_Configuration() {
        XCTAssertNotNil(sut.loaderComponent)
    }
    
    func testShowLoading() {
        sut.showLoading()
        XCTAssertTrue(sut.loaderComponent.activityIndicator.isAnimating)
    }
    
    func testHideLoading() {
        sut.hideLoading()
        XCTAssertFalse(sut.loaderComponent.activityIndicator.isAnimating)
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
