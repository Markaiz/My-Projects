//
//  EndGameViewController.swift
//  TapGame
//
//  Created by Mark on 21/11/2017.
//  Copyright © 2017 MarkAiz. All rights reserved.
//

import UIKit

class EndGameViewController: UIViewController {

    @IBOutlet weak var scoreSheetlbl: UILabel!
    @IBOutlet weak var finalScoreLbl: UILabel!
    @IBOutlet weak var shareSheetlbl: UILabel!
    @IBOutlet weak var shareBtnlbl: UIButton!
    @IBOutlet weak var restartBtnoutlet: UIButton!
    
    var scoreData:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
scoreSheetlbl.layer.cornerRadius = 5.0
        shareBtnlbl.layer.cornerRadius = 5.0
        shareSheetlbl.layer.cornerRadius = 5.0
        restartBtnoutlet.layer.cornerRadius = 5.0
        
        finalScoreLbl.text = scoreData
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func restartAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        self.presentingViewController?.dismiss(animated: false, completion: nil)
        
        
    }
    

}
