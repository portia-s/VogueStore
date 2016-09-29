//
//  ProductModel.swift
//  VogueStore
//
//  Created by Portia Sharma on 9/28/16.
//  Copyright © 2016 Portia Sharma. All rights reserved.
//

import Foundation
import UIKit


struct product {
    
    var name = "productName"
    var price = "productPrice"
    var image = UIImage()
    
}

class productData {
    
    func getProductData() -> [product] {
       
        var productArray = [product]()
        
        var product1 = product()
        product1.name = "Sneakers A"
        product1.price = "$49.95"
        product1.image = UIImage(named:"shoesBorder")!
        productArray.append(product1)
        
        product1.name = "Shoes B"
        product1.price = "$79.95"
        product1.image = UIImage(named:"ShoesBBorder")!
        productArray.append(product1)

        product1.name = "Dress A"
        product1.price = "$99.00"
        product1.image = UIImage(named:"dressA")!
        productArray.append(product1)

        product1.name = "Dress B"
        product1.price = "$89.00"
        product1.image = UIImage(named:"dressB")!
        productArray.append(product1)

        return productArray
    }
    
}
