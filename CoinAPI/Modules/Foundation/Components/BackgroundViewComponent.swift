import UIKit

class BackgroundViewComponent: UIView {
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .gray
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
