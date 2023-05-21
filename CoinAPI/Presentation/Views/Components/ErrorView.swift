import UIKit

protocol ErrorViewDelegate: AnyObject {
    func refreshButtonTapped()
}

class ErrorView: UIView {
    
    weak var delegate: ErrorViewDelegate?
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Refresh", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
     override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupActions()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupActions()
    }
    
    private func setupViews() {
        addSubview(errorLabel)
        addSubview(refreshButton)
        
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            refreshButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 16),
            refreshButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            refreshButton.widthAnchor.constraint(equalToConstant: 120),
            refreshButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setError(message: String) {
        errorLabel.text = message
    }
    
    private func setupActions() {
        refreshButton.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
    }
    
    @objc private func refreshButtonTapped() {
        delegate?.refreshButtonTapped()
    }

}
