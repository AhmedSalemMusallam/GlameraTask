//
//  CharacterCollectionViewCell.swift
//  TaskGlamera
//
//  Created by Ahmed Salem on 27/03/2024.
//

import UIKit
import SDWebImage

class CharacterCollectionViewCell: UICollectionViewCell {

    //outlets
    @IBOutlet weak var CharacterBGView: UIView!
    
    @IBOutlet weak var CharacterImageView: UIImageView!
    
    
    @IBOutlet weak var TitleLable: UILabel!
    
    //variables
    static let reuseIdentifier = "CharacterCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(item:CharacterModelResult?)
    {
        let imagePath = item?.thumbnail?.path ?? ""
        let imageExtension = item?.thumbnail?.Extension ?? ""
        let FullURL = "\(imagePath).\(imageExtension)"
        
        let url = URL(string:  FullURL)
        let placeholderImage = UIImage(named: "CharaterDemo1")
        CharacterImageView.sd_setImage(with: url, placeholderImage: placeholderImage ,options: SDWebImageOptions(rawValue: 0), completed: { (img, err, cacheType, imgURL) in
            // code
        })
        
        let itemName = item?.name ?? ""
        TitleLable.text = "\(itemName.prefix(12))"
    }

}
