import Foundation

public enum HttpError: Error {
    case noConnectivity
    case badRequest
    case serverError
    case unauthorized
    case forbidden
    case decodeError
    case noData
    case invalidURL
    case networkError
}

extension HttpError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .decodeError:
            return "Error during data decoding"
        case .noData:
            return "No data returned"
        case .invalidURL:
            return "Invalid url, verify the url"
        case .networkError:
            return "An error has occurred. Please verify your connection."
        case .noConnectivity:
            return "No connectivity. Verify your internet"
        case .unauthorized:
            return "Unauthorized, verify your access."
        case .badRequest:
            return "Bad request, try again later."
        case .serverError:
            return "Server error, try again later"
        case .forbidden:
            return "Forbidden, try again later"
        }
    }
}
