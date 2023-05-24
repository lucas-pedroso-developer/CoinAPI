import UIKit

class CircleViewComponent: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
        self.layer.cornerRadius = min(frame.width, frame.height) / 2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = min(frame.width, frame.height) / 2
    }
    
    override var frame: CGRect {
        didSet {
            setNeedsLayout()
        }
    }
    
    func configure(size: CGSize, backgroundColor: UIColor, borderWidth: CGFloat, borderColor: UIColor) {
        self.frame.size = size
        self.backgroundColor = backgroundColor
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
}
