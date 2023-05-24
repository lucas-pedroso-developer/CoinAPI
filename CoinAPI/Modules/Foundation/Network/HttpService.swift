import Foundation

public protocol HttpGetClient {
    func get(url: URL?, completion: @escaping (Result<Data?, HttpError>) -> Void)
}

public final class HttpService: HttpGetClient {
    
    // MARK: - Properties
    
    private let session: URLSession
    
    // MARK: - Initialization
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - HttpGetClient
    
    /// Performs a GET request to the specified URL and returns the result via a completion block.
    /// - Parameters:
    ///   - url: The URL to which the GET request will be made.
    ///   - completion: A closure that is called once the request is complete. It returns a `Result` object containing either the retrieved data or an `HttpError` in case of failure.
    public func get(url: URL?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        let headers: [String: String] = ["X-CoinAPI-Key": APIRoute.apiKey]
        guard let urlUnwrapped = url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: urlUnwrapped)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.noConnectivity))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.noData))
                return
            }
            
            debugPrint(request)
            
            if let data = data {
                if let responseData = String(data: data, encoding: .utf8) {
                    debugPrint(responseData)
                }
            }
            
            let statusCode = httpResponse.statusCode
            
            switch statusCode {
            case 204:
                completion(.success(nil))
            case 200...299:
                completion(.success(data))
            case 401:
                completion(.failure(.unauthorized))
            case 403:
                completion(.failure(.forbidden))
            case 400...499:
                completion(.failure(.badRequest))
            case 500...599:
                completion(.failure(.serverError))
            default:
                completion(.failure(.noConnectivity))
            }
        }.resume()
    }
}
