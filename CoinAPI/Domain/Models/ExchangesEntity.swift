struct ExchangesEntity : Codable {
    let exchangeId : String?
    let website : String?
    let name : String?
    let dataStart : String?
    let dataEnd : String?
    let dataQuoteStart : String?
    let dataQuoteEnd : String?
    let dataOrderbookStart : String?
    let dataOrderbookEnd : String?
    let dataTradeStart : String?
    let dataTradeEnd : String?
    let dataSymbolsCount : Int?
    let volume1hrsUsd : Double?
    let volume1dayUsd : Double?
    let volume1mthUsd : Double?
    var icon: String?

    enum CodingKeys: String, CodingKey {
        case exchangeId = "exchange_id"
        case website = "website"
        case name = "name"
        case dataStart = "data_start"
        case dataEnd = "data_end"
        case dataQuoteStart = "data_quote_start"
        case dataQuoteEnd = "data_quote_end"
        case dataOrderbookStart = "data_orderbook_start"
        case dataOrderbookEnd = "data_orderbook_end"
        case dataTradeStart = "data_trade_start"
        case dataTradeEnd = "data_trade_end"
        case dataSymbolsCount = "data_symbols_count"
        case volume1hrsUsd = "volume_1hrs_usd"
        case volume1dayUsd = "volume_1day_usd"
        case volume1mthUsd = "volume_1mth_usd"
        case icon = "icon"
    }
    
    init(
            exchangeId: String?,
            website: String?,
            name: String?,
            dataStart: String?,
            dataEnd: String?,
            dataQuoteStart: String?,
            dataQuoteEnd: String?,
            dataOrderbookStart: String?,
            dataOrderbookEnd: String?,
            dataTradeStart: String?,
            dataTradeEnd: String?,
            dataSymbolsCount: Int?,
            volume1hrsUsd: Double?,
            volume1dayUsd: Double?,
            volume1mthUsd: Double?,
            icon: String?
        ) {
            self.exchangeId = exchangeId
            self.website = website
            self.name = name
            self.dataStart = dataStart
            self.dataEnd = dataEnd
            self.dataQuoteStart = dataQuoteStart
            self.dataQuoteEnd = dataQuoteEnd
            self.dataOrderbookStart = dataOrderbookStart
            self.dataOrderbookEnd = dataOrderbookEnd
            self.dataTradeStart = dataTradeStart
            self.dataTradeEnd = dataTradeEnd
            self.dataSymbolsCount = dataSymbolsCount
            self.volume1hrsUsd = volume1hrsUsd
            self.volume1dayUsd = volume1dayUsd
            self.volume1mthUsd = volume1mthUsd
            self.icon = icon
        }


    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        exchangeId = try values.decodeIfPresent(String.self, forKey: .exchangeId)
        website = try values.decodeIfPresent(String.self, forKey: .website)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        dataStart = try values.decodeIfPresent(String.self, forKey: .dataStart)
        dataEnd = try values.decodeIfPresent(String.self, forKey: .dataEnd)
        dataQuoteStart = try values.decodeIfPresent(String.self, forKey: .dataQuoteStart)
        dataQuoteEnd = try values.decodeIfPresent(String.self, forKey: .dataQuoteEnd)
        dataOrderbookStart = try values.decodeIfPresent(String.self, forKey: .dataOrderbookStart)
        dataOrderbookEnd = try values.decodeIfPresent(String.self, forKey: .dataOrderbookEnd)
        dataTradeStart = try values.decodeIfPresent(String.self, forKey: .dataTradeStart)
        dataTradeEnd = try values.decodeIfPresent(String.self, forKey: .dataTradeEnd)
        dataSymbolsCount = try values.decodeIfPresent(Int.self, forKey: .dataSymbolsCount)
        volume1hrsUsd = try values.decodeIfPresent(Double.self, forKey: .volume1hrsUsd)
        volume1dayUsd = try values.decodeIfPresent(Double.self, forKey: .volume1dayUsd)
        volume1mthUsd = try values.decodeIfPresent(Double.self, forKey: .volume1mthUsd)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
    }
}

extension ExchangesEntity {
    static func mapFromIconsData(iconsEntity: [IconsEntity], exchangesEntity: [ExchangesEntity]) -> [ExchangesEntity] {
        var exchanges: [ExchangesEntity] = []
        for (_, element) in exchangesEntity.enumerated() {
            let exchange = ExchangesEntity(
                exchangeId: element.exchangeId,
                website: element.website,
                name: element.name,
                dataStart: element.dataStart,
                dataEnd: element.dataEnd,
                dataQuoteStart: element.dataQuoteStart,
                dataQuoteEnd: element.dataQuoteEnd,
                dataOrderbookStart: element.dataOrderbookStart,
                dataOrderbookEnd: element.dataOrderbookEnd,
                dataTradeStart: element.dataTradeStart,
                dataTradeEnd: element.dataTradeEnd,
                dataSymbolsCount: element.dataSymbolsCount,
                volume1hrsUsd: element.volume1hrsUsd,
                volume1dayUsd: element.volume1dayUsd,
                volume1mthUsd: element.volume1mthUsd,
                icon: iconsEntity.first(where: { $0.exchangeId == element.exchangeId })?.url
            )
            exchanges.append(exchange)
        }
        return exchanges
    }
}
