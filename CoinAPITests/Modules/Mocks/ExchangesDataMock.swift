func getExchangesDataJSON() -> String {
    
    let JSON = """
    
    [
        {
            "exchange_id": "BINANCE",
            "website": "https://www.binance.com/",
            "name": "Binance",
            "data_start": "2017-07-14",
            "data_end": "2023-05-18",
            "data_quote_start": "2017-12-18T21:50:58.3910192Z",
            "data_quote_end": "2023-05-18T00:00:00.0000000Z",
            "data_orderbook_start": "2017-12-18T21:50:58.3910192Z",
            "data_orderbook_end": "2023-05-18T00:00:00.0000000Z",
            "data_trade_start": "2017-07-14T04:00:00.3760000Z",
            "data_trade_end": "2023-05-18T00:00:00.0000000Z",
            "data_symbols_count": 2232,
            "volume_1hrs_usd": 175313095.08,
            "volume_1day_usd": 7265142962.90,
            "volume_1mth_usd": 242790209589.08
        },
      {
          "exchange_id": "COINBASE",
          "website": "https://pro.coinbase.com/",
          "name": "Coinbase Pro (GDAX)",
          "data_start": "2015-01-14",
          "data_end": "2023-05-18",
          "data_quote_start": "2015-05-17T00:51:32.6370000Z",
          "data_quote_end": "2023-05-18T00:00:00.0000000Z",
          "data_orderbook_start": "2015-05-17T00:51:32.6370000Z",
          "data_orderbook_end": "2023-05-18T00:00:00.0000000Z",
          "data_trade_start": "2015-01-14T16:07:05.0000000Z",
          "data_trade_end": "2023-05-18T00:00:00.0000000Z",
          "data_symbols_count": 669,
          "volume_1hrs_usd": 24196572.04,
          "volume_1day_usd": 870682137.43,
          "volume_1mth_usd": 31301131823.81
      }
    ]
    
    """
    return JSON
}
