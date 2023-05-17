import Foundation

extension NumberFormatter {
    static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter
    }()

    static func formatCurrency(value: Double) -> String? {
        return currencyFormatter.string(from: NSNumber(value: value))
    }
}
