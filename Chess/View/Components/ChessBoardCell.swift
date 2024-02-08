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
            self.backgroundColor = #colorLiteral(red: 0.9702178836, green: 0.8668905497, blue: 0.7201874852, alpha: 1)
            
        } else {
            self.backgroundColor = #colorLiteral(red: 0.1664624214, green: 0.27115798, blue: 0.4278879166, alpha: 1)
        }
    }
}
