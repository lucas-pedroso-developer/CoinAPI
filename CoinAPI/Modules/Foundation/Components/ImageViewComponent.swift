import UIKit

class ImageViewComponent: UIImageView {
    init() {
        super.init(frame: .zero)
        self.contentMode = .scaleAspectFit
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

