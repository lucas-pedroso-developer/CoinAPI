protocol HomeUseCaseProtocol {
    func getExchanges(completion: @escaping (Result<Void, Error>) -> Void)
}

class HomeUseCase: HomeUseCaseProtocol {
    private let homeRepository: HomeRepositoryProtocol

    init(homeRepository: HomeRepositoryProtocol) {
        self.homeRepository = homeRepository
    }

    func getExchanges(completion: @escaping (Result<Void, Error>) -> Void) {
        homeRepository.getExchanges() { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
