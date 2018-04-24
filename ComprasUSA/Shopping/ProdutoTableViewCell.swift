//
//  ProdutoTableViewCell.swift
//  ComprasUSA
//
//  Created by admin on 4/21/18.
//  Copyright © 2018 Carlos P Caldas. All rights reserved.
//

import UIKit

class ProdutoTableViewCell: UITableViewCell{
    
    
    @IBOutlet weak var lbProductName: UILabel!
    @IBOutlet weak var lbEstado: UILabel!
    @IBOutlet weak var lbValor: UILabel!
    @IBOutlet weak var lbSimNao: UILabel!
    @IBOutlet weak var ivTitle: UIImageView!
    
    
    
    
    override func awakeFromNib(){
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
