import UIKit

class DetailCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private let exchange: ExchangesEntity
    
    init(navigationController: UINavigationController, exchange: ExchangesEntity) {
        self.navigationController = navigationController
        self.exchange = exchange
    }
    
    func start() {
        let detailViewController = DetailViewController(exchange: exchange)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
