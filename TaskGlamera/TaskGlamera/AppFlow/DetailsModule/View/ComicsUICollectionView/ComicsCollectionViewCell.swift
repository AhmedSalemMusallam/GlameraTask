//
//  ComicsCollectionViewCell.swift
//  TaskGlamera
//
//  Created by Ahmed Salem on 27/03/2024.
//

import UIKit
import SDWebImage

class ComicsCollectionViewCell: UICollectionViewCell {
    
    //outlets
    @IBOutlet weak var ComicsImageView: UIImageView!
    
    //variables
    static let reuseIdentifier = "ComicsCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(item:DetailsModelResult?)
    {
        let imagePath = item?.thumbnail?.path ?? ""
        let imageExtension = item?.thumbnail?.Extension ?? ""
        let FullURL = "\(imagePath).\(imageExtension)"
        
        let url = URL(string:  FullURL)
        let placeholderImage = UIImage(named: "CharaterDemo1")
        ComicsImageView.sd_setImage(with: url, placeholderImage: placeholderImage ,options: SDWebImageOptions(rawValue: 0), completed: { (img, err, cacheType, imgURL) in
            // code
        })
    }
    

}
