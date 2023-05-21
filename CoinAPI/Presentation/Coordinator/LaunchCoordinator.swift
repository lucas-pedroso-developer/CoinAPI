import UIKit

class LaunchCoordinator: Coordinator {
    private let window: UIWindow
    private var launchScreenViewController: LaunchScreenViewController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let launchScreenViewController = LaunchScreenViewController()
        self.launchScreenViewController = launchScreenViewController
        window.rootViewController = launchScreenViewController
        window.makeKeyAndVisible()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showHomeViewController()
        }
    }
    
    private func showHomeViewController() {
        let homeViewController = HomeViewController()
        let homeCoordinator = HomeCoordinator(window: window, rootViewController: homeViewController)
        homeCoordinator.start()
        launchScreenViewController = nil
    }

}
