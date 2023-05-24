import UIKit

class DetailCoordinator: Coordinator {
    
    // MARK: - Properties
    
    private let navigationController: UINavigationController
    private let exchange: ExchangesEntity
    
    // MARK: - Initialization
    
    init(navigationController: UINavigationController, exchange: ExchangesEntity) {
        self.navigationController = navigationController
        self.exchange = exchange
    }
    
    // MARK: - Coordinator Methods
    
    func start() {
        let detailViewController = DetailViewController(exchange: exchange)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
