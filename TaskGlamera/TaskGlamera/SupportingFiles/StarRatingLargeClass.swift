//
//  StarRatingLargeClass.swift
//  Frooter
//
//  Created by Ahmed Salem on 26/03/2024.
//

import Foundation
import UIKit
class StarRatingLargeView: UIStackView {
    private var starImageViews: [UIImageView] = []
    var rating: Int = 0 {
        didSet {
            updateStarRating()
        }
    }
    
    var starHeight:CGFloat = 35
    var starWidth:CGFloat = 35
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    
    private func setupView() {
        axis = .horizontal
        spacing = 4
        
        // Create and add the star image views to the stack view
        for _ in 1...5 {
            let starImageView = UIImageView()
            starImageView.image = UIImage(named: "star") // Set the empty star image
            starImageView.contentMode = .scaleAspectFit
            starImageView.translatesAutoresizingMaskIntoConstraints = false
            starImageView.heightAnchor.constraint(equalToConstant: starHeight).isActive = true
            starImageView.widthAnchor.constraint(equalToConstant: starWidth).isActive = true
            addArrangedSubview(starImageView)
            
            starImageViews.insert(starImageView, at: 0) // Insert the star image view at the beginning of the array
        }
        
        updateStarRating()
        
        // Add tap gesture recognizer to handle user interaction
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapStar(_:)))
        addGestureRecognizer(tapGesture)
    }

    
    @objc private func didTapStar(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self)
        let starWidth = bounds.width / CGFloat(starImageViews.count)
        let selectedRating = Int(location.x / starWidth) + 1
        rating = selectedRating
    }
    
    private func updateStarRating() {
        for (index, starImageView) in starImageViews.enumerated() {
            if index+1 < rating {
                starImageView.image = UIImage(named: "LStar") // Set the empty star image
            } else {
                starImageView.image = UIImage(named: "LStar-x") // Set the filled star image
            }
        }
    }
    
    
    // Add a method to get the current rating value
        func getRating() -> Int {
            var rightToLeftRate: [Int: Int] = [Int: Int]()
            rightToLeftRate[1] = 5
            rightToLeftRate[2] = 4
            rightToLeftRate[3] = 3
            rightToLeftRate[4] = 2
            rightToLeftRate[5] = 1
            return rightToLeftRate[rating] ?? 5
        }
}
