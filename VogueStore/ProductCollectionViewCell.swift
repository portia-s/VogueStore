//
//  ProductCollectionViewCell.swift
//  VogueStore
//
//  Created by Portia Sharma on 9/28/16.
//  Copyright © 2016 Portia Sharma. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var addToCartButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bringSubview(toFront: addToCartButton)
    }

    @IBAction func addToCartButtonPressed(_ sender: UIButton) {
    }
    
}
