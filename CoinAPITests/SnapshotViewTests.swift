import SnapshotTesting
import XCTest
@testable import CoinAPI

class SnapshotHomeViewControllerTests: XCTestCase {
    
    func test_ViewController() {
        let viewController = HomeViewController()
        assertSnapshot(matching: viewController, as: .image)
    }
    
    func test_DetailViewController() {
        let viewController = DetailViewController(exchange: getExchangeDataMock())
        assertSnapshot(matching: viewController, as: .image)
    }
    
    func test_HomeTableViewCell() {
        let frame = CGRect(x: 0, y: 0, width: 300, height: 56.0)
        let cell = ExchangesCell(frame: frame)
        cell.setupCell(title: "BINANCE",
                       subtitle: "BINANCE",
                       value: 7265142962.90,
                       icon: "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_32/74eaad903814407ebdfc3828fe5318ba.png")
        assertSnapshot(matching: cell, as: .image)
    }
}

extension SnapshotHomeViewControllerTests {
    func getExchangeDataMock() -> ExchangesEntity {
        let JSON = getExchangesDataJSON()
        let jsonData = JSON.data(using: .utf8)!
        let exchanges = try? JSONDecoder().decode([ExchangesEntity].self, from: jsonData)
        return (exchanges?.first)!
    }
}
