protocol HomeRepositoryProtocol {
    func getExchanges(completion: @escaping (Result<ExchangesEntity, Error>) -> Void)
}

class HomeRepository: HomeRepositoryProtocol {

    func getExchanges(completion: @escaping (Result<ExchangesEntity, Error>) -> Void) {
        //call alamofire
    }
}
