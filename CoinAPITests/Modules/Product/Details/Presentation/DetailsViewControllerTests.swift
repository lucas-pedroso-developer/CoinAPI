import XCTest
@testable import CoinAPI

class DetailViewControllerTests: XCTestCase {
    
    var sut: DetailViewController!
    
    override func setUp() {
        super.setUp()
        
        let exchange = getExchangeDataMock()
        sut = DetailViewController(exchange: exchange)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testNavBarTitle() {
        XCTAssertEqual(sut.title, "DETAIL")
    }
    
    func testImageViewNotNil() {
        XCTAssertNotNil(sut.iconImageView)
    }
    
    func testLabelsNotNil() {
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertNotNil(sut.subtitleLabel)
        XCTAssertNotNil(sut.volumeOneHourLabel)
        XCTAssertNotNil(sut.volumeOneDayLabel)
        XCTAssertNotNil(sut.volumeOneMonthLabel)
        XCTAssertNotNil(sut.websiteLabel)
    }
}


extension DetailViewControllerTests {
    func getExchangeDataMock() -> ExchangesEntity {
        let JSON = getExchangesDataJSON()
        let jsonData = JSON.data(using: .utf8)!
        let exchange = try! JSONDecoder().decode([ExchangesEntity].self, from: jsonData)
        return exchange.first!
    }
}
