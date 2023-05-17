protocol HomeViewModelProtocol {
    func getNumberOfRows(index: Int) -> Int
    func getExchangeId(index: Int) -> String
    func getExchangeName(index: Int) -> String
    func getVolumeDayOne(index: Int) -> Double
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
}

extension HomeViewModel {
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

extension HomeViewModel {
    func getNumberOfRows(index: Int) -> Int {
        return exchangesEntity?.count ?? Int()
    }
    
    func getExchangeId(index: Int) -> String {
        return exchangesEntity?[index]?.exchangeId ?? String()
    }
    
    func getExchangeName(index: Int) -> String {
        return exchangesEntity?[index]?.name ?? String()
    }
    
    func getVolumeDayOne(index: Int) -> Double {
        return exchangesEntity?[index]?.volume1dayUsd ?? Double()
    }
}
