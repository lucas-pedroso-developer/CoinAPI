protocol HomeViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(message: String)
}
