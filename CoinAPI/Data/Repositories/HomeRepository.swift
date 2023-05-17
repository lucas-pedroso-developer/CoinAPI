import Foundation

protocol HomeRepositoryProtocol {
    func getExchanges(completion: @escaping (Result<ExchangesEntity, HttpError>) -> Void)
}

class HomeRepository: HomeRepositoryProtocol {

    let network: HttpGetClient
    
    init(network: HttpGetClient) {
        self.network = network
    }
    
    func getExchanges(completion: @escaping (Result<ExchangesEntity, HttpError>) -> Void) {
        guard let url = URL(string: "") else { return }
        network.get(to: url) { [weak self] result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                guard let dataUnwraped = data else { return completion(.failure(.noData)) }
                do {
                    let exchangesEntity = try JSONDecoder().decode(ExchangesEntity.self, from: dataUnwraped)
                    completion(.success(exchangesEntity))
                } catch {
                    completion(.failure(.decodeError))
                }
            }
        }
    }
}
