import UIKit
import QuartzCore
import Kingfisher

class ExchangesCell: UITableViewCell {
    
    var imageURL: URL?

    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let valueLabel = UILabel()
    let iconImageView = UIImageView()

    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.cancelImageLoad()
    }
    
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
            let cacheKey = "\(url)"
            if let cachedImage = ImageCache.default.retrieveImageInMemoryCache(forKey: cacheKey) {
                self.iconImageView.image = cachedImage
            } else {
                ImageCache.default.retrieveImage(forKey: cacheKey) { result in
                    switch result {
                    case .success(let cacheResult):
                        if let cachedImage = cacheResult.image {
                            self.iconImageView.image = cachedImage
                        } else {
                            let resource = ImageResource(downloadURL: url)
                            self.iconImageView.kf.setImage(with: resource) { result in
                                switch result {
                                case .success(let imageResult):
                                    ImageCache.default.store(imageResult.image, forKey: cacheKey)
                                case .failure(let error):
                                    print("Download image error: \(error.localizedDescription)")
                                }
                            }
                        }
                    case .failure(let error):
                        print("Retrieve image from cache error: \(error.localizedDescription)")
                    }
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
