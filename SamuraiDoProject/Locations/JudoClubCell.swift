//
//  JudoClubCell.swift
//  SamuraiDoProject
//
//  Created by Mark on 16/10/2017.
//  Copyright © 2017 MarkAiz. All rights reserved.
//

import UIKit

class JudoClubCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(with branch : JudoClub){
        nameLabel.text = branch.name
    }

}
