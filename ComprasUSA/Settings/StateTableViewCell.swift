//
//  StateTableViewCell.swift
//  ComprasUSA
//
//  Created by admin on 4/22/18.
//  Copyright © 2018 Carlos P Caldas. All rights reserved.
//

import UIKit

class StateTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lbState: UILabel!
    @IBOutlet weak var lbTax: UILabel!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

