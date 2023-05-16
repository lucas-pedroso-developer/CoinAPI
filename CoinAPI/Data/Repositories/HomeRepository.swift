import Foundation

protocol HomeRepositoryProtocol {
    func getExchanges(completion: @escaping (Result<ExchangesEntity, Error>) -> Void)
}

class HomeRepository: HomeRepositoryProtocol {

    let network: HttpGetClient
    
    init(network: HttpGetClient) {
        self.network = network
    }
    
    func getExchanges(completion: @escaping (Result<ExchangesEntity, Error>) -> Void) {
        guard let url = URL(string: "") else { return }
        network.get(to: url) { [weak self] result in
            switch result {
            case .failure:
                break
            case .success:
                break
            }
        }
    }
}
