import UIKit

class HomeCoordinator: Coordinator {
    private let window: UIWindow
    private let rootViewController: UIViewController
    
    init(window: UIWindow, rootViewController: UIViewController) {
        self.window = window
        self.rootViewController = rootViewController
    }
    
    func start() {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
