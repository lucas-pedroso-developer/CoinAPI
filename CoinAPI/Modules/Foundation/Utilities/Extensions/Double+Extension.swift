import Foundation

// MARK: - NumberFormatter Extension

extension NumberFormatter {
    static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()

    static func formatCurrency(value: Double) -> String? {
        return currencyFormatter.string(from: NSNumber(value: value))
    }
}
