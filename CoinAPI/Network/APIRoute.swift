import Foundation

enum APIRoute {
    static var url: URL? {
        return URL(string: "https://rest.coinapi.io/v1/exchanges")
    }
    static var iconsURL: URL? {
        return URL(string: "https://rest.coinapi.io/v1/exchanges/icons/512")
    }
    static var apiKey: String {
        return "7B5F5C8F-0F6E-463E-924D-C4797FAD71F3"
    }
}
