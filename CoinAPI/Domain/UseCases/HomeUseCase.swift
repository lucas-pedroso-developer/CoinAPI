protocol HomeUseCaseProtocol {
    func getExchanges(completion: @escaping (Result<ExchangesEntity, Error>) -> Void)
}

class HomeUseCase: HomeUseCaseProtocol {
    private let homeRepository: HomeRepositoryProtocol

    init(homeRepository: HomeRepositoryProtocol) {
        self.homeRepository = homeRepository
    }

    func getExchanges(completion: @escaping (Result<ExchangesEntity, Error>) -> Void) {
        homeRepository.getExchanges() { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
