import Combine
import Foundation

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
    
    // MARK: - Properties
    
    var exchangesEntity: [ExchangesEntity?]?
    var iconsEntity: [IconsEntity?]?
    weak var view: HomeViewProtocol?
    private let homeUseCase: HomeUseCaseProtocol
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    
    init(view: HomeViewProtocol, homeUseCase: HomeUseCaseProtocol) {
        self.view = view
        self.homeUseCase = homeUseCase
    }
}

extension HomeViewModel {
    
    // MARK: - Methods
    
    func getExchanges() {
        
        view?.showLoading()
        
        let exchangesPublisher = Future<[ExchangesEntity], Error> { promise in
            self.homeUseCase.getExchanges { result in
                switch result {
                case .success(let exchangesData):
                    promise(.success(exchangesData))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
            .receive(on: DispatchQueue.main)
        
        let iconsPublisher = Future<[IconsEntity], Error> { promise in
            self.homeUseCase.getExchangesIcons { result in
                switch result {
                case .success(let iconsData):
                    promise(.success(iconsData))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
            .receive(on: DispatchQueue.main)
        
        Publishers.Zip(exchangesPublisher, iconsPublisher)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    let errorMessage: String
                    if let customError = error as? HttpError {
                        errorMessage = customError.localizedDescription
                    } else {
                        errorMessage = "Failed to fetch exchanges"
                    }
                    self.view?.showError(message: errorMessage)
                    self.view?.hideLoading()
                }
            }, receiveValue: { [weak self] exchangesData, iconsData in
                guard let self = self else { return }
                
                self.exchangesEntity = ExchangesEntity.mapFromIconsData(iconsEntity: iconsData, exchangesEntity: exchangesData)
                self.view?.reloadTableView()
            })
            .store(in: &cancellables)
    }
}

extension HomeViewModel {
    
    // MARK: - Methods
    
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
        guard let exchange = exchangesEntity?[index] else { return nil }
        return exchange
    }
}
