//
//  CharacterPopUpViewController.swift
//  TaskGlamera
//
//  Created by Ahmed Salem on 27/03/2024.
//

import UIKit
import SDWebImage

class CharacterPopUpViewController: UIViewController {

    //outlets
    @IBOutlet weak var CharacterImageView: UIImageView!
    
    @IBOutlet weak var TitleLable: UILabel!
    //Actions
    @IBAction func CloseAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    //variables
    var comicItem:DetailsModelResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureScreenWithData()
    }
    
    func ConfigureScreenWithData()
    {
        print("ConfigureScreenWithData")
        guard let itemData = comicItem else { return }
        TitleLable.text = itemData.title ?? ""
        
        let imagePath = itemData.thumbnail?.path ?? ""
        let imageExtension = itemData.thumbnail?.Extension ?? ""
        let FullURL = "\(imagePath).\(imageExtension)"
        
        let url = URL(string:  FullURL)
        let placeholderImage = UIImage(named: "CharaterDemo1")
        CharacterImageView.sd_setImage(with: url, placeholderImage: placeholderImage ,options: SDWebImageOptions(rawValue: 0), completed: { (img, err, cacheType, imgURL) in
            // code
        })
    }

}
