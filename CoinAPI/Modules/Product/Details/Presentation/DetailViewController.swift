import UIKit
import Kingfisher

// MARK: - Constants
enum DetailConstants: String {
    case title = "detail"
    case volumeHour = "volumeHour"
    case volumeDay = "volumeDay"
    case volumeMonth = "volumeMonth"
}

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let exchange: ExchangesEntity
    
    let iconImageView = ImageViewComponent()
    let titleLabel = LabelComponent()
    let subtitleLabel = LabelComponent()
    let backgroundUIView = BackgroundViewComponent()
    let circleView = CircleViewComponent()
    let volumeOneHourLabel = LabelComponent()
    let volumeOneDayLabel = LabelComponent()
    let volumeOneMonthLabel = LabelComponent()
    let websiteLabel = LabelComponent()
    
    
    // MARK: - Initialization
    
    init(exchange: ExchangesEntity) {
        self.exchange = exchange
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        populateData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        circleView.layer.cornerRadius = circleView.frame.width / 2
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        setupBackgroundUIView()
        setupCircleView()
        setupImageView()
        setupLabels()
        setupWebsiteLabel()
        setupNavBarTitle()
    }
    
    private func setupNavBarTitle() {
        self.title = NSLocalizedString(Constants.title.rawValue, comment: String())
    }
    
    private func setupImageView() {
        view.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 70),
            iconImageView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func setupBackgroundUIView() {
        view.addSubview(backgroundUIView)
        
        NSLayoutConstraint.activate([
            backgroundUIView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            backgroundUIView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            backgroundUIView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            backgroundUIView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupLabels() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(volumeOneHourLabel)
        view.addSubview(volumeOneDayLabel)
        view.addSubview(volumeOneMonthLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            volumeOneHourLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8),
            volumeOneHourLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            volumeOneDayLabel.topAnchor.constraint(equalTo: volumeOneHourLabel.bottomAnchor, constant: 8),
            volumeOneDayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            volumeOneMonthLabel.topAnchor.constraint(equalTo: volumeOneDayLabel.bottomAnchor, constant: 8),
            volumeOneMonthLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
        ])
    }
    
    private func setupCircleView() {
        view.addSubview(circleView)
        
        circleView.configure(size: CGSize(width: 140, height: 140),
                             backgroundColor: UIColor.lightGray,
                             borderWidth: 2.0,
                             borderColor: UIColor.black)
        
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: backgroundUIView.bottomAnchor, constant: -70),
            circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            circleView.widthAnchor.constraint(equalToConstant: 140),
            circleView.heightAnchor.constraint(equalToConstant: 140)
        ])
        circleView.clipsToBounds = true
    }
    
    private func setupWebsiteLabel() {
        view.addSubview(websiteLabel)
        
        NSLayoutConstraint.activate([
            websiteLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            websiteLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            websiteLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
        
        websiteLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(websiteLabelTapped))
        websiteLabel.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Data Population
    
    private func populateData() {
        self.loadImage(icon: exchange.icon ?? String())
        titleLabel.configure(text: exchange.exchangeId ?? String(), font: UIFont.systemFont(ofSize: 40), isBold: true)
        subtitleLabel.configure(text: exchange.name ?? String(), font: UIFont.systemFont(ofSize: 25), isBold: true)
        
        let volumeHourText = NSLocalizedString(DetailConstants.volumeHour.rawValue, comment: String()) + " - " + (NumberFormatter.formatCurrency(value: exchange.volume1hrsUsd ?? Double()) ?? String())
        let volumeDayText = NSLocalizedString(DetailConstants.volumeDay.rawValue, comment: String()) + " - " + (NumberFormatter.formatCurrency(value: exchange.volume1dayUsd ?? Double()) ?? String())
        let volumeMonthText = NSLocalizedString(DetailConstants.volumeMonth.rawValue, comment: String()) + " - " + (NumberFormatter.formatCurrency(value: exchange.volume1mthUsd ?? Double()) ?? String())
        
        volumeOneHourLabel.configure(text: volumeHourText, font: UIFont.systemFont(ofSize: 20), textColor: .green)
        volumeOneDayLabel.configure(text: volumeDayText, font: UIFont.systemFont(ofSize: 20), textColor: .green)
        volumeOneMonthLabel.configure(text: volumeMonthText, font: UIFont.systemFont(ofSize: 20), textColor: .green)
        
        websiteLabel.configure(text: exchange.website ?? String(), font: UIFont.systemFont(ofSize: 14), textColor: .blue)
        websiteLabel.attributedText = NSAttributedString.makeHyperlink(for: exchange.website ?? String(), in: "Visit us")
    }
    
    // MARK: - Event Handling
    
    @objc private func websiteLabelTapped() {
        guard let website = exchange.website, let url = URL(string: website) else { return }
        UIApplication.shared.open(url)
    }
    
    // MARK: - Image Loading
    
    private func loadImage(icon: String) {
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
                            self.iconImageView.image = UIImage(named: "no-image")
                        }
                    case .failure(let error):
                        self.iconImageView.image = UIImage(named: "no-image")
                        print("Retrieve image from cache error: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
}
