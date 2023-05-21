import UIKit
import QuartzCore

class ExchangesCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let valueLabel = UILabel()
    let iconImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellLayout()
        animateCellOnLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(title: String, subtitle: String, value: Double, icon: String) {
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        self.valueLabel.text = NumberFormatter.formatCurrency(value: value)
        self.loadImage(icon: icon)
    }
    
    private func loadImage(icon: String) {
        self.iconImageView.image = UIImage(named: "no-image")
        if let url = URL(string: icon) {
            iconImageView.loadImage(from: url) { [weak self] image in
                DispatchQueue.main.async {
                    self?.iconImageView.image = image
                    return
                }
            }
        }
    }
    
    private func setupImageView() {
        iconImageView.contentMode = .scaleAspectFit
    }
    
    private func animateCellOnLoad() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 1
        layer.add(animation, forKey: "cellLoadAnimation")
    }
    
    private func setupCellLayout() {
        setupLabelSize()
        setupLabelColor()
        setupImageView()
        addSubviews()
        configureConstraints()
    }
    
    private func setupLabelSize() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        valueLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
    private func setupLabelColor() {
        titleLabel.textColor = .black
        subtitleLabel.textColor = .black
        valueLabel.textColor = .black
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(valueLabel)
        addSubview(iconImageView)
    }
    
    private func configureConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
