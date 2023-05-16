import Foundation

protocol HomeViewModelProtocol {
    func getExchanges()
}

class HomeViewModel: HomeViewModelProtocol {
    
    weak var view: HomeViewProtocol?

    init(view: HomeViewProtocol) {
        self.view = view
    }
    
    func getExchanges() {
        view?.showLoading()
        //create method
        view?.hideLoading()
    }
    
}
