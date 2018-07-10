//
//  PictureCollectionViewCell.swift
//  UberChallenge
//
//  Created by Saalis Umer on 7/8/18.
//  Copyright © 2018 Saalis Umer. All rights reserved.
//

import UIKit
let PictureCollectionViewCell_Identifier = "PictureCollectionViewCell"

class PictureCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView:UIImageView?
    @IBOutlet weak var label:UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.label?.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
    }
    
    override var reuseIdentifier: String?
    {
        return PictureCollectionViewCell_Identifier
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView?.image = nil
    }
    
    func setImage(image:UIImage)
    {
        self.imageView?.image = image
    }
}
