import UIKit

protocol TableViewComponentDelegate: AnyObject {
    func didSelectRow(at indexPath: IndexPath)
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
}

class TableViewComponent: UIView, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: TableViewComponentDelegate?
    
    var tableView: UITableView!
    var dataSource: UITableViewDataSource?
    
    init(dataSource: UITableViewDataSource) {
        super.init(frame: .zero)
        self.dataSource = dataSource
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = dataSource
        addSubview(tableView)
        configureTableViewConstraints()
    }
    
    private func configureTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func registerCell<T: UITableViewCell>(_ cellClass: T.Type, forCellReuseIdentifier identifier: String) {
        tableView.register(cellClass, forCellReuseIdentifier: identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.tableView(tableView, numberOfRowsInSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dataSource?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return delegate?.heightForRowAt(indexPath: indexPath) ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectRow(at: indexPath)
    }
    
    func selectRow(at indexPath: IndexPath) {
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        delegate?.didSelectRow(at: indexPath)
    }
}
