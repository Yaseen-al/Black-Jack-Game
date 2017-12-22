//
//  HistoryGameViewController.swift
//  2017_12_22 Black Jack Mid Unit Asessment
//
//  Created by C4Q on 12/22/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import UIKit

class HistoryGameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var playersTableView: UITableView!
    var players = [Player](){
        didSet{
            playersTableView.reloadData()
        }
    }
    @IBAction func resetHistoryButton(_ sender: UIButton) {
        playerDataModel.shared.resetList()
        self.players = playerDataModel.shared.getPlayerList()
        let alert = UIAlertController(title: "History Cleared", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let playerSetup = players[indexPath.row]
//    let cell = self.playersTableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as!
//        PlayerTableViewCell
        let crazyCell = self.playersTableView.dequeueReusableCell(withIdentifier: "crazyCell") as! CustomTableViewCell
        crazyCell.cards = playerSetup.cardSet
        crazyCell.playerScore.text = "Final Hand Score:\(playerSetup.score)"
        return crazyCell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playersTableView.delegate = self
        self.playersTableView.dataSource = self
        // Set the NIB
        let nib =  UINib(nibName: "PlayerTableViewCell", bundle: nil)
        self.playersTableView.register(nib, forCellReuseIdentifier: "PlayerTableViewCell")
        playerDataModel.shared.loadPlayerList()
        self.players = playerDataModel.shared.getPlayerList()

    }
    override func viewWillAppear(_ animated: Bool) {
        playerDataModel.shared.loadPlayerList()
        self.players = playerDataModel.shared.getPlayerList()
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
