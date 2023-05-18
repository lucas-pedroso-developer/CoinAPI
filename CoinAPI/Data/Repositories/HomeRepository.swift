import Foundation

protocol HomeRepositoryProtocol {
    func getExchanges(completion: @escaping (Result<[ExchangesEntity], HttpError>) -> Void)
}

class HomeRepository: HomeRepositoryProtocol {

    let network: HttpGetClient
    
    
    init(network: HttpGetClient) {
        self.network = network
    }
    
    func getExchanges(completion: @escaping (Result<[ExchangesEntity], HttpError>) -> Void) {
        network.get(url: getURL()) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                guard let dataUnwraped = data else { return completion(.failure(.noData)) }
                do {
                    let exchangesEntity = try JSONDecoder().decode([ExchangesEntity].self, from: dataUnwraped)
                    completion(.success(exchangesEntity))
                } catch {
                    completion(.failure(.decodeError))
                }
            }
        }
    }
    
    private func getURL() -> URL? {
        return APIRoute.url
    }
}
