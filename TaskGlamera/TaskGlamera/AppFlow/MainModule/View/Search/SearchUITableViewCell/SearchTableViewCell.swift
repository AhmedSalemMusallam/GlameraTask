//
//  SearchTableViewCell.swift
//  TaskGlamera
//
//  Created by Ahmed Salem on 29/03/2024.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    //outlets
    @IBOutlet weak var nameLabel: UILabel!
    
    //variables
    static let reuseIdentifier = "SearchTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(item:CharacterModelResult?)
    {
        let itemName = item?.name ?? ""
        nameLabel.text = "\(itemName.prefix(20))"
    }
}
