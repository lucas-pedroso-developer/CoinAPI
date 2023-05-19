class HomeViewModelBuilder {
    ///  Creates an instance of `HomeViewModel` by instantiating its dependencies.
    /// - Parameter view: The `HomeViewProtocol` object that will be associated with the `HomeViewModel`.
    /// - Returns: An instance of `HomeViewModelProtocol`.
    func createViewModel(view: HomeViewProtocol) -> HomeViewModelProtocol {
        let network = AlamofireAdapter()
        let repository = HomeRepository(network: network)
        let useCase = HomeUseCase(homeRepository: repository)
        let viewModel = HomeViewModel(view: view, homeUseCase: useCase)
        return viewModel
    }
}
