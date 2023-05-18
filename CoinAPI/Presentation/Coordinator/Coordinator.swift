import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    var navigationController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewController = HomeViewController()
        navigationController = UINavigationController(rootViewController: viewController)
        viewController.coordinator = self
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func showDetails(exchangeEntity: ExchangesEntity?) {
        guard let exchange = exchangeEntity else { return }
        let viewController = DetailViewController(exchange: exchange)
        viewController.coordinator = self
        navigationController?.pushViewController(viewController, animated: true)
    }
}
