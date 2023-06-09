import UIKit

// MARK: - Protocol

protocol HomeViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(message: String)
    func reloadTableView()
}

// MARK: - Constants

enum Constants: String {
    case title = "home"
    case cell = "ExchangesCell"
}
//case volumeHour = "volumeHour"
class HomeViewController: UIViewController {

    // MARK: - Properties
    
    var errorComponent: ErrorComponent?
    var tableViewComponent: TableViewComponent?
    var detailCoordinator: DetailCoordinator?
    var viewModel: HomeViewModelProtocol?
    var loaderComponent: LoaderComponent?

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        createViewModel()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        view.backgroundColor = .white
    }

    // MARK: - Setup
    
    func setupViews() {
        setupLoaderComponent()
        setuptableViewComponent()
        setupNavigationController()
    }

    private func createViewModel() {
        let dependencies = HomeViewModelConfigurator.Dependencies(view: self)
        viewModel = HomeViewModelConfigurator.make(with: dependencies)
        getExchanges()
    }

    func getExchanges() {
        viewModel?.getExchanges()
    }

    // MARK: - Navigation Controller Setup
    
    private func setupNavigationController() {
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
        ]
        self.title = NSLocalizedString(Constants.title.rawValue, comment: String()) 
    }
    
    // MARK: - Table View Component Setup
    
    private func setuptableViewComponent() {
        self.tableViewComponent = TableViewComponent(dataSource: self)
        self.tableViewComponent?.registerCell(ExchangesCell.self, forCellReuseIdentifier: Constants.cell.rawValue)
        self.tableViewComponent?.backgroundColor = .clear
        self.tableViewComponent?.dataSource = self
        self.tableViewComponent?.delegate = self
        self.tableViewComponent?.isUserInteractionEnabled = true
        view.addSubview(tableViewComponent ?? UITableView())
        configureTableViewComponentConstraints()
    }


    private func configureTableViewComponentConstraints() {
        self.tableViewComponent?.translatesAutoresizingMaskIntoConstraints = false
        self.tableViewComponent?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.tableViewComponent?.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        self.tableViewComponent?.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        self.tableViewComponent?.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }

    // MARK: - Loader Component Setup
    
    private func setupLoaderComponent() {
        self.loaderComponent = LoaderComponent()
        view.addSubview(loaderComponent ?? UIView())
        configureLoaderComponentConstraints()
    }

    private func configureLoaderComponentConstraints() {
        self.loaderComponent?.translatesAutoresizingMaskIntoConstraints = false
        self.loaderComponent?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.loaderComponent?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.loaderComponent?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.loaderComponent?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension HomeViewController: TableViewComponentDelegate {
    
    // MARK: - TableViewComponentDelegate
    
    func didSelectRow(at indexPath: IndexPath) {
        guard let selectedExchange = viewModel?.getSelectedExchange(index: indexPath.row) else { return }
        let detailCoordinator = DetailCoordinator(navigationController: navigationController ?? UINavigationController(), exchange: selectedExchange)
        detailCoordinator.start()
        self.detailCoordinator = detailCoordinator
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
}

extension HomeViewController: UITableViewDataSource {

    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRows(index: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell.rawValue, for: indexPath) as? ExchangesCell else { return UITableViewCell() }
        cell.selectionStyle = .none

        if let exchangeId = viewModel?.getExchangeId(index: indexPath.row),
           let exchangeName = viewModel?.getExchangeName(index: indexPath.row),
           let volumeDayOne = viewModel?.getVolumeDayOne(index: indexPath.row),
           let icon = viewModel?.getIcon(index: indexPath.row) {
            cell.setupCell(title: exchangeId, subtitle: exchangeName, value: volumeDayOne, icon: icon)
        }

        return cell
    }
}

extension HomeViewController: HomeViewProtocol {

    // MARK: - HomeViewProtocol
    
    func showLoading() {
        loaderComponent?.startLoading()
    }

    func hideLoading() {
        loaderComponent?.stopLoading()
    }

    func showError(message: String) {
        errorComponent = ErrorComponent(message: message)
        errorComponent?.delegate = self
        view.addSubview(errorComponent ?? UIView())
        configureErrorComponentConstraints()
    }
    
    private func configureErrorComponentConstraints() {
        errorComponent?.translatesAutoresizingMaskIntoConstraints = false
        errorComponent?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        errorComponent?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        errorComponent?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        errorComponent?.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func hideErrorComponent() {
        errorComponent?.removeFromSuperview()
        errorComponent = nil
    }

    func reloadTableView() {
        tableViewComponent?.reloadData()
    }
}



extension HomeViewController: ErrorComponentDelegate {
    
    // MARK: - ErrorComponentDelegate
    
    func didTapRefresh() {
        hideErrorComponent()
        getExchanges()
    }
}
