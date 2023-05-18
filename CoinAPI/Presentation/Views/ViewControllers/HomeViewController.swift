import UIKit

protocol HomeViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(message: String)
    func reloadTableView()
}

enum Constants: String {
    case title = "COIN API"
    case cell = "ExchangesCell"
}

class HomeViewController: UIViewController {
    
    var tableView: UITableView!
    var coordinator: AppCoordinator?
    var viewModel: HomeViewModelProtocol?
    let loaderViewController = LoadingViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        createViewModel()
    }
    
    func setupViews() {
        setuptableView()
        setupNavigationController()
    }
    
    private func createViewModel() {
        let builder = HomeViewModelBuilder()
        viewModel = builder.createViewModel(view: self)
        viewModel?.getExchanges()
    }
    
    private func setupNavigationController() {
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
        ]
        self.title = Constants.title.rawValue
    }
    
    private func setuptableView() {
        self.tableView = UITableView(frame: .zero)
        self.tableView.register(ExchangesCell.self, forCellReuseIdentifier: Constants.cell.rawValue)
        self.tableView.backgroundColor = .clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
        view.addSubview(tableView)
        configureTableViewConstraints()
    }
    
    private func configureTableViewConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRows(index: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell.rawValue, for: indexPath) as! ExchangesCell
        cell.setupCell(
            title: viewModel?.getExchangeId(index: indexPath.row) ?? String(),
            subtitle: viewModel?.getExchangeName(index: indexPath.row) ?? String(),
            value: viewModel?.getVolumeDayOne(index: indexPath.row) ?? Double(),
            icon: viewModel?.getIcon(index: indexPath.row) ?? String())
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.showDetails(exchangeEntity: viewModel?.getSelectedExchange(index: indexPath.row))
    }
}

extension HomeViewController: HomeViewProtocol {
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func showLoading() {
        loaderViewController.modalPresentationStyle = .fullScreen
        present(loaderViewController, animated: false, completion: nil)
        loaderViewController.startLoading()
    }
    
    func hideLoading() {
        loaderViewController.stopLoading()
    }
    
    func showError(message: String) {
        print("show error")
    }
}
