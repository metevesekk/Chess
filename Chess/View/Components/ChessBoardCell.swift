//
//  ChessBoardCell.swift
//  Chess
//
//  Created by Mete Vesek on 8.02.2024.
//

import UIKit

class ChessBoardCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        self.backgroundColor = .white
    }

    func configureCell(at indexPath: IndexPath) {
        if (indexPath.row / 8 + indexPath.row % 8) % 2 == 0 {
            self.backgroundColor = ThemeManager.colorCode("F7DDB8", alpha: 1)
            
        } else {
            self.backgroundColor = ThemeManager.colorCode("2A456D", alpha: 1)
        }
    }
}
