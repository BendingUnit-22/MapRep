//
//  WorkoutView.swift
//  MaxRep
//
//  Created by Rixing on 8/4/16.
//  Copyright © 2016 Rixing Wu. All rights reserved.
//

import UIKit

class WorkoutView: UIView {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var nextLabel: UILabel!
    
}


class HeaderCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var routine: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
}



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
