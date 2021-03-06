//
//  MatchTableViewCell.swift
//  PlacaresNFL
//
//  Created by Nichollas Fonseca on 31/10/15.
//  Copyright © 2015 Nichollas Fonseca. All rights reserved.
//

import UIKit

class MatchTableViewCell: UITableViewCell {

    @IBOutlet var team1: UILabel!
    @IBOutlet var score1: UILabel!
    @IBOutlet var team2: UILabel!
    @IBOutlet var score2: UILabel!
    @IBOutlet var logo1: UIImageView!
    @IBOutlet var logo2: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet var gameTime: UILabel!

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
