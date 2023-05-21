import UIKit

class DetailViewController: UIViewController {
    
    var coordinator: Coordinator?
    private let exchange: ExchangesEntity
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let backgroundUIView: UIView = {
        let uiview = UIView(frame: CGRect.zero)
        uiview.backgroundColor = .gray
        uiview.translatesAutoresizingMaskIntoConstraints = false
        return uiview
    }()
    
    private let circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let volumeOneHourLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let volumeOneDayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let volumeOneMonthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let websiteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    
    init(exchange: ExchangesEntity) {
        self.exchange = exchange
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        populateData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        circleView.layer.cornerRadius = circleView.frame.width / 2
    }
    
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
        self.title = "DETAIL"
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(websiteLabelTapped))
        websiteLabel.addGestureRecognizer(tapGesture)
    }
    
    private func populateData() {
        self.loadImage(icon: exchange.icon ?? "")
        titleLabel.text = exchange.exchangeId
        subtitleLabel.text = exchange.name
        volumeOneHourLabel.text = "Volume/hora - " + (NumberFormatter.formatCurrency(value: exchange.volume1hrsUsd ?? Double()) ?? "")
        volumeOneDayLabel.text = "Volume/dia - " + (NumberFormatter.formatCurrency(value: exchange.volume1dayUsd ?? Double()) ?? "")
        volumeOneMonthLabel.text = "Volume/Mês - " + (NumberFormatter.formatCurrency(value: exchange.volume1mthUsd ?? Double()) ?? "")
        websiteLabel.text = exchange.website
    }
    
    @objc private func websiteLabelTapped() {
        guard let website = exchange.website, let url = URL(string: website) else { return }
        UIApplication.shared.open(url)
    }
    
    private func loadImage(icon: String) {
        if let url = URL(string: icon) {
            iconImageView.loadImage(from: url) { [weak self] image in
                DispatchQueue.main.async {
                    self?.iconImageView.image = image
                }
            }
        }
    }
}
