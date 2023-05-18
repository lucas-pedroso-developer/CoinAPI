import Foundation

enum APIRoute {
    static var url: URL? {
        return URL(string: "https://rest.coinapi.io/v1/exchanges")
    }
    static var iconsURL: URL? {
        return URL(string: "https://rest.coinapi.io/v1/exchanges/icons/32")
    }
    static var apiKey: String {
        return "1D19140B-BF5D-4AAF-A931-092D8C162D4A"
    }
}
