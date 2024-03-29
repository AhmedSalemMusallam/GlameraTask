//
//  CustomCollectionViewFlowLayout.swift
//  Frooter
//
//  Created by Ahmed Salem on 12/01/2024.
//

import Foundation
import UIKit

class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        
        for updateItem in updateItems {
            if let indexPath = updateItem.indexPathAfterUpdate, updateItem.updateAction == .insert {
                let attributes = layoutAttributesForItem(at: indexPath)
                attributes?.alpha = 0.0
                attributes?.transform = CGAffineTransform(translationX: 0, y: 20)
            }
        }
    }

    override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()
        
        for indexPath in collectionView?.indexPathsForVisibleItems ?? [] {
            let attributes = layoutAttributesForItem(at: indexPath)
            attributes?.alpha = 1.0
            attributes?.transform = .identity
        }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes
        guard let collectionView = collectionView else { return attributes }

        let cellWidth = collectionView.bounds.width * 0.8
        let cellHeight = collectionView.bounds.height - 20

        attributes?.size = CGSize(width: cellWidth, height: cellHeight)

        let centerX = (collectionView.bounds.width - cellWidth) / 2
        let centerY = collectionView.contentOffset.y + 20 + cellHeight / 2

        attributes?.center = CGPoint(x: centerX, y: centerY)

        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
