import Alamofire

public protocol HttpGetClient {
    func get(url: URL?, completion: @escaping (Result<Data?, HttpError>) -> Void)
}


public final class AlamofireAdapter: HttpGetClient {
    private let session : Session
    
    public init(session: Session = .default) {
        self.session = session
    }
    
    /// Performs a GET request to the specified URL and returns the result via a completion block.
    /// - Parameters:
    ///   - url: The URL to which the GET request will be made.
    ///   - completion: A closure that is called once the request is complete. It returns a `Result` object containing either the retrieved data or an `HttpError` in case of failure.
    public func get(url: URL?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        let headers: HTTPHeaders = [ "X-CoinAPI-Key": APIRoute.apiKey ]
        guard let urlUwraped = url else { return completion(.failure(.invalidURL)) }
        session.request(urlUwraped, method: .get, headers: headers).responseData { dataResponse in
            guard let statusCode = dataResponse.response?.statusCode else { return
                completion(.failure(.noConnectivity)) }
            debugPrint(dataResponse)
            switch dataResponse.result {
                case .failure: completion(.failure(.noConnectivity))
                case .success(let data):
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
            }
        }
    }
}
