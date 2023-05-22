enum HomeViewModelConfigurator: FeatureFactory {
    
    ///  Creates an instance of `HomeViewModel` by instantiating its dependencies.
    /// - Parameter view: The `HomeViewProtocol` object that will be associated with the `HomeViewModel`.
    /// - Returns: An instance of `HomeViewModelProtocol`.
    
    struct Dependencies {
        let view: HomeViewProtocol
    }
     
    static func make(with dependencies: Dependencies) -> HomeViewModelProtocol {
        let network = AlamofireAdapter()
        let repository = HomeRepository(network: network)
        let useCase = HomeUseCase(homeRepository: repository)
        let viewModel = HomeViewModel(view: dependencies.view, homeUseCase: useCase)
        return viewModel
    }
}
