import UIKit

class LabelComponent: UILabel {
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String, font: UIFont = UIFont(name: "San Francisco", size: 13)!, textColor: UIColor = .black, isBold: Bool = false, isItalic: Bool = false) {
        self.text = text
        self.font = font
        self.textColor = textColor
        
        var traits: UIFontDescriptor.SymbolicTraits = []
        if isBold {
            traits.insert(.traitBold)
        }
        if isItalic {
            traits.insert(.traitItalic)
        }
        
        if let descriptor = font.fontDescriptor.withSymbolicTraits(traits) {
            self.font = UIFont(descriptor: descriptor, size: font.pointSize)
        }
    }
}
