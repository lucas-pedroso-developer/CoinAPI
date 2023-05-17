import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.coordinator = self
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
