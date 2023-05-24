import UIKit

protocol ErrorComponentDelegate: AnyObject {
    func didTapRefresh()
}

class ErrorComponent: UIView, ErrorComponentDelegate {
    
    // MARK: - Properties
    
    var message: String
    weak var delegate: ErrorComponentDelegate?
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Refresh", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initialization
    
    init(message: String) {
        self.message = message
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        setDescription() // Adicione essa linha para configurar o texto da descriptionLabel
        refreshButton.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        addSubview(backgroundView)
        addSubview(descriptionLabel)
        addSubview(refreshButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            refreshButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            refreshButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16)
        ])
    }
    
    func setDescription() {
        descriptionLabel.text = message
    }
    
    @objc private func refreshButtonTapped() {
        self.didTapRefresh()
    }
    
    // MARK: - ErrorComponentDelegate Methods
    
    func didTapRefresh() {
        delegate?.didTapRefresh()
    }
}
