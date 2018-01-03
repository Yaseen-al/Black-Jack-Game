//
//  CustomTableViewCell.swift
//  2017_12_22 Black Jack Mid Unit Asessment
//
//  Created by C4Q on 12/22/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell, UICollectionViewDataSource,UICollectionViewDelegate {
    var cards = [Card](){
        didSet{
            playerCollectionView.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    @IBOutlet weak var playerScore: UILabel!
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard indexPath.row < cards.count else {
//            return UICollectionViewCell()
//        }
        let cardSetup = cards[indexPath.row]
        let cell = playerCollectionView.dequeueReusableCell(withReuseIdentifier: "specialCardCell", for: indexPath) as! CardCollectionViewCell
        cell.cardLabel.text = "cardValue:\(cardSetup.valueInt)"
        cell.cardPoster.image = #imageLiteral(resourceName: "bower-logo")
        ImageAPIClient.manager.getImage(from: cardSetup.images.png, completionHandler: {cell.cardPoster.image = $0; cell.setNeedsLayout()}, errorHandler: {print($0)})
        return cell
    }


    @IBOutlet weak var playerCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.playerCollectionView.delegate = self
        self.playerCollectionView.dataSource = self
        // Set the NIB
        let nib =  UINib(nibName: "CardCollectionViewCell", bundle: nil)
        self.playerCollectionView.register(nib, forCellWithReuseIdentifier: "specialCardCell")
        print("it has awaken")
                print(cards.count)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


//
//func setCollectionViewDataSourceDelegate
//    <D: UICollectionViewDataSource & UICollectionViewDelegate>
//    (dataSourceDelegate: D, forRow row: Int) {
//    playerCollectionView.delegate = dataSourceDelegate
//    playerCollectionView.dataSource = dataSourceDelegate
//    playerCollectionView.tag = row
//    playerCollectionView.reloadData()
//}

