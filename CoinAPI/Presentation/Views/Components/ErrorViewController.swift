import UIKit

protocol ErrorViewControllerDelegate: AnyObject {
    func didTapRefresh()
}

class ErrorViewController: UIViewController {
    
    private let errorView = ErrorView()
    weak var delegate: ErrorViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        errorView.delegate = self
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(white: 10, alpha: 0.5)
        view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setError(message: String) {
        errorView.setError(message: message)
    }
}

extension ErrorViewController: ErrorViewDelegate {
    func refreshButtonTapped() {
        self.dismiss(animated: true) {
            self.delegate?.didTapRefresh()
        }
    }
}
