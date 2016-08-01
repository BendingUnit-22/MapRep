//
//  WorkoutSelectionCell.swift
//  MaxRep
//
//  Created by Rixing Wu on 7/5/16.
//  Copyright © 2016 Rixing Wu. All rights reserved.
//

import UIKit
import Foundation
import ChameleonFramework

class WorkoutSelectionCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var routine: UILabel!
    
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    override func drawRect(rect: CGRect) {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.flatWhiteColor().CGColor
    }
    
}
