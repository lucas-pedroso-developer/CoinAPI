import Foundation

// MARK: - String Extension

extension NSAttributedString {
    static func makeHyperlink(for urlString: String, in string: String) -> NSAttributedString {
        let attributedString = NSAttributedString(string: string, attributes: [.link: urlString])
        return attributedString
    }
}
