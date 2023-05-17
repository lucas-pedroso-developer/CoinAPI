protocol HomeViewModelProtocol {
    func getExchanges()
}

class HomeViewModel: HomeViewModelProtocol {
    var exchangesEntity: [ExchangesEntity?]?
    weak var view: HomeViewProtocol?
    private let homeUseCase: HomeUseCaseProtocol
    
    init(view: HomeViewProtocol, homeUseCase: HomeUseCaseProtocol) {
        self.view = view
        self.homeUseCase = homeUseCase
    }
    
    func getExchanges() {
        view?.showLoading()
        homeUseCase.getExchanges() { [weak self] result in
            self?.view?.hideLoading()
            switch result {
            case .success(let data):
                self?.exchangesEntity = data
                self?.view?.reloadTableView()
                break
            case .failure(let error):
                self?.view?.showError(message: error.localizedDescription)
            }
        }
    }
}
