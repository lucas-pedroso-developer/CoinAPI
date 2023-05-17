import Alamofire

public protocol HttpGetClient {
    func get(completion: @escaping (Result<Data?, HttpError>) -> Void)
}

public final class AlamofireAdapter: HttpGetClient {
    private let session : Session
    
    public init(session: Session = .default) {
        self.session = session
    }
    
    public func get(completion: @escaping (Result<Data?, HttpError>) -> Void) {
        guard let url = APIRoute.url else { return completion(.failure(.invalidURL)) }
        let headers: HTTPHeaders = [ "X-CoinAPI-Key": APIRoute.apiKey ]
        session.request(url, method: .get, headers: headers).responseData { dataResponse in
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
