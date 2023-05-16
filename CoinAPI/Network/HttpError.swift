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
    case invalidStatusCode
    case networkError
}

extension HttpError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .decodeError:
            return "Error during data decoding"
        case .noData:
            return "Data error"
        case .invalidURL:
            return "Invalid URL"
        case .invalidStatusCode:
            return "Invalid status code"
        case .networkError:
            return "An error has occurred. Please verify your connection."
        case .noConnectivity:
            return "No connectivity"
        case .unauthorized:
            return "Unauthorized"
        case .badRequest:
            return "Bad request"
        case .serverError:
            return "Server error"
        case .forbidden:
            return "forbidden"
        }
    }
}
