//
//  CardDeck APIClient.swift
//  2017_12_22 Black Jack Mid Unit Asessment
//
//  Created by C4Q on 12/22/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation
struct CardDeckAPIClient {
    private init() {}
    static let manager = CardDeckAPIClient()
    func getCardDeck(completionHandler: @escaping (CardDeck) -> Void, errorHandler: @escaping (AppError) -> Void) {
        let urlStr = "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=6"
        guard let url = URL(string: urlStr) else {
            errorHandler(.badURL)
            return
        }
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let cardDeck = try JSONDecoder().decode(CardDeck.self, from: data)
                completionHandler(cardDeck)
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
