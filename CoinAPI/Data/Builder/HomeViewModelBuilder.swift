class HomeViewModelBuilder {
    func createViewModel(view: HomeViewProtocol) -> HomeViewModelProtocol {
        let network = AlamofireAdapter()
        let repository = HomeRepository(network: network)
        let useCase = HomeUseCase(homeRepository: repository)
        let viewModel = HomeViewModel(view: view, homeUseCase: useCase)
        return viewModel
    }
}
