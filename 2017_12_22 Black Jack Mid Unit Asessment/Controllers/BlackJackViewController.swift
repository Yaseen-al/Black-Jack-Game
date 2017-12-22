//
//  BlackJackViewController.swift
//  2017_12_22 Black Jack Mid Unit Asessment
//
//  Created by C4Q on 12/22/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import UIKit

class BlackJackViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var stopOutlet: UIButton!
    @IBOutlet weak var drawCardOutlet: UIButton!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var blackJackCollectionView: UICollectionView!
    var cards = [Card](){
        didSet{
            self.player = Player(cardSet: cards)
            blackJackCollectionView.reloadData()
            guard let player = player else {
                return
            }
            self.currentScoreLabel.text = "Your Hand score: \(player.score)"
            print("Win:\(player.win), score:\(player.score)")
        }
    }
    var cardDeck:CardDeck?{
        didSet{
            if let cardDeck = cardDeck{
                loadCards(from: cardDeck)
            }
        }
    }
    var player: Player?{
        didSet{
            // TODO: check win status and alert View as well as save to th NS ARchive
            if let player = player{
            if player.score > 30{
                self.drawCardOutlet.isEnabled = false
                playerDataModel.shared.addPlayerToPlayerList(player: player)
                let alert = UIAlertController(title: "Game Over", message: "You have lost", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                        alert.addAction(action)
                present(alert, animated: true, completion: {self.tabBarController?.selectedIndex = 0})
                self.cards.removeAll()
                self.drawCardOutlet.isEnabled = true
            }
            else if player.score == 30{
                currentScoreLabel.text = "You Won Score: \(player.score)"
                self.drawCardOutlet.isEnabled = false
                playerDataModel.shared.addPlayerToPlayerList(player: player)
                let alert = UIAlertController(title: "Bust", message: "You have won", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                        alert.addAction(action)
                present(alert, animated: true, completion: {self.tabBarController?.selectedIndex = 0})
                self.cards.removeAll()
                self.drawCardOutlet.isEnabled = true
                }
            }

        }
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        // TODO: alert View and print the win stats

        self.cards.removeAll()
        self.drawCardOutlet.isEnabled = true
    }
    @IBAction func drawCardButton(_ sender: UIButton) {

        guard let cardDeck = cardDeck else {
        loadCardDeck()
            return
        }
        loadCards(from: cardDeck)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cardSetup =  cards[indexPath.row]
        let cell = blackJackCollectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
        cell.cardLabel.text = "Card Value: \(cardSetup.valueInt)"
        ImageAPIClient.manager.getImage(from: cardSetup.images.png, completionHandler: {cell.cardPoster.image = $0}, errorHandler: {print($0)})
                    self.blackJackCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.bottom, animated: true)

        return cell
    }
    
    func loadCardDeck() {
        CardDeckAPIClient.manager.getCardDeck(completionHandler: {self.cardDeck = $0; print($0.deckId)}, errorHandler: {print($0)})
    }
    func loadCards(from CardDeck: CardDeck){
        CardAPIClient.manager.getCard(from: CardDeck.deckId, completionHandler: {self.cards.append($0); print($0.code, $0.valueInt)}, errorHandler: {print($0)})
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.blackJackCollectionView.delegate = self
        self.blackJackCollectionView.dataSource = self
        //Intialize the nib
        let nib = UINib(nibName: "CardCollectionViewCell", bundle: nil)
        //Register the nib to the collectionView
        self.blackJackCollectionView.register(nib, forCellWithReuseIdentifier: "CardCollectionViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
