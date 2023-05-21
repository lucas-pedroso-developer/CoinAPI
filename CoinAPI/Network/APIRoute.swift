import Foundation

enum APIRoute {
    
    static var url: URL? {
        return URL(string: "https://rest.coinapi.io/v1/exchanges")
    }
    
    static var iconsURL: URL? {
        return URL(string: "https://rest.coinapi.io/v1/exchanges/icons/512")
    }
    
    static var apiKey: String {
        if let path = Bundle.main.path(forResource: "APIKey", ofType: "plist"),
            let config = NSDictionary(contentsOfFile: path),
            let apiKey = config["API_KEY"] as? String {
            return apiKey
        }
        return ""
    }
}
