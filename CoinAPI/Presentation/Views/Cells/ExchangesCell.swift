import UIKit

class ExchangesCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let valueLabel = UILabel()

    func setupCell(title: String, subtitle: String, value: Double) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        valueLabel.text = NumberFormatter.formatCurrency(value: value)

        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(valueLabel)
    }
}
