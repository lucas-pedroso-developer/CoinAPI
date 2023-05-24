struct IconsEntity: Codable, Equatable {
    
    // MARK: - Properties
    
    let exchangeId: String?
    let url: String?
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case exchangeId = "exchange_id"
        case url = "url"
    }
    
    // MARK: - Decodable
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        exchangeId = try values.decodeIfPresent(String.self, forKey: .exchangeId)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
}
