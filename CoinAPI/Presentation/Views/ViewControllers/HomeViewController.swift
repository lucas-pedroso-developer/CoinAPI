import UIKit

protocol HomeViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(message: String)
    func reloadTableView()
}

enum Constants: String {
    case title = "COIN API"
}

class HomeViewController: UIViewController {
    
    var tableView: UITableView!
    var coordinator: AppCoordinator?
    var viewModel: HomeViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        createViewModel()
    }
    
    func setupViews() {
        setupLabel()
        setupLines()
        setuptableView()
    }
    
    private func createViewModel() {
        let builder = HomeViewModelBuilder()
        viewModel = builder.createViewModel(view: self)
        viewModel?.getExchanges()
    }
    
    private func setupLabel() {
        let label = UILabel()
        label.text = Constants.title.rawValue
        label.textColor = .black
        label.textAlignment = .center
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    private func setupLines() {
        let uiView = UIView()
        uiView.backgroundColor = .lightGray
        view.addSubview(uiView)
        uiView.translatesAutoresizingMaskIntoConstraints = false
        uiView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        uiView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        uiView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        uiView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
    }
    
    private func setuptableView() {
        self.tableView = UITableView(frame: .zero)
        self.tableView.backgroundColor = .clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
        view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRows(index: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        return cell
    }
}

extension HomeViewController: HomeViewProtocol {
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func showLoading() {
        print("show loading")
    }
    
    func hideLoading() {
        print("hide loading")
    }
    
    func showError(message: String) {
        print("show error")
    }
}
