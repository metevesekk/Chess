//
//  ChessCell.swift
//  Chess
//
//  Created by Mete Vesek on 25.11.2023.
//

import UIKit

class ChessCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        self.backgroundColor = .white // Varsayılan renk
    }

    // Hücrenin satranç tahtasındaki konumuna göre rengini ayarlayın
    func configureCell(at indexPath: IndexPath) {
        if (indexPath.row / 8 + indexPath.row % 8) % 2 == 0 {
            self.backgroundColor = .white
        } else {
            self.backgroundColor = .black
        }
    }
}

