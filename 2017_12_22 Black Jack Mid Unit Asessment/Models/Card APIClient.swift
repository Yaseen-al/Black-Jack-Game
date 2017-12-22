//
//  Card APIClient.swift
//  2017_12_22 Black Jack Mid Unit Asessment
//
//  Created by C4Q on 12/22/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation

struct CardAPIClient {
    private init() {}
    static let manager = CardAPIClient()
    func getCard(from cardDeckID: String, completionHandler: @escaping (Card) -> Void, errorHandler: @escaping (AppError) -> Void) {
        let urlStr = "https://deckofcardsapi.com/api/deck/\(cardDeckID)/draw/?count=2"
        guard let url = URL(string: urlStr) else {
            errorHandler(.badURL)
            return
        }
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let cardWraper = try JSONDecoder().decode(CardWraper.self, from: data)
                if let card = cardWraper.cards.first{
                completionHandler(card)
                }else{
                    errorHandler(.noDataReceived)
                }
            }
            catch {
                errorHandler(.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: {print($0)})
    }
}
