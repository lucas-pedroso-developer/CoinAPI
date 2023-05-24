import UIKit

class BackgroundViewComponent: UIView {
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .gray
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
