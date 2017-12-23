//
//  VictimCell.swift
//  HitListAryaCoreData
//
//  Created by Mark on 04/09/2017.
//  Copyright © 2017 MarkAiz. All rights reserved.
//

import UIKit

class VictimCell: UITableViewCell {

    @IBOutlet weak var firstNamelabel: UILabel!
    @IBOutlet weak var lastNamelabel: UILabel!
    
    func configure(with victim : Victim)
    {
    firstNamelabel.text = victim.firstName
        lastNamelabel.text = victim.lastName
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
