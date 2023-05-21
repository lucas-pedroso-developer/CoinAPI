import UIKit

class LoadingViewController: UIViewController {
    
    private let loadingView = LoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(white: 10, alpha: 0.5)
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func startLoading() {
        loadingView.startLoading()
    }
    
    func stopLoading() {
        loadingView.stopLoading()
        dismiss(animated: false, completion: nil)
    }
}
