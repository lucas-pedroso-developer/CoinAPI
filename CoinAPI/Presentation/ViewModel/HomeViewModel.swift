import PromiseKit

protocol HomeViewModelProtocol {
    func getNumberOfRows(index: Int) -> Int
    func getExchangeId(index: Int) -> String
    func getExchangeName(index: Int) -> String
    func getVolumeDayOne(index: Int) -> Double
    func getIcon(index: Int) -> String
    func getSelectedExchange(index: Int) -> ExchangesEntity?
    func getExchanges() 
    
}

class HomeViewModel: HomeViewModelProtocol {
    
    var exchangesEntity: [ExchangesEntity?]?
    var iconsEntity: [IconsEntity?]?
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
        
        let exchangesPromise = Promise<[ExchangesEntity]> { seal in
            homeUseCase.getExchanges { result in
                switch result {
                case .success(let exchangesData):
                    seal.fulfill(exchangesData)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
        
        let iconsPromise = Promise<[IconsEntity]> { seal in
            homeUseCase.getExchangesIcons { result in
                switch result {
                case .success(let iconsData):
                    seal.fulfill(iconsData)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
        
        firstly {
            when(fulfilled: exchangesPromise, iconsPromise)
        }.done { (exchangesData: [ExchangesEntity], iconsData: [IconsEntity]) in
            self.exchangesEntity = ExchangesEntity.mapFromIconsData(iconsEntity: iconsData, exchangesEntity: exchangesData)
            self.view?.reloadTableView()
        }.catch { error in
            let errorMessage: String
            if let customError = error as? HttpError {
                errorMessage = customError.localizedDescription
            } else {
                errorMessage = "Failed to fetch exchanges"
            }
            self.view?.showError(message: errorMessage)
        }.finally {
            self.view?.hideLoading()
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
    
    func getIcon(index: Int) -> String {
        return exchangesEntity?[index]?.icon ?? String()
    }
    
    func getSelectedExchange(index: Int) -> ExchangesEntity? {
        return (exchangesEntity?[index])
    }
}
