//
//  ChessBoardCell.swift
//  Chess
//
//  Created by Mete Vesek on 8.02.2024.
//

import UIKit

class ChessBoardCell: UICollectionViewCell {
    let pieceImage = UIImageView()
    let letterLabel = UILabel()
    let numberLabel = UILabel()
    let letters = ["a", "b", "c" ,"d", "e", "f", "g", "h"]
    let numbers = ["8", "7", "6", "5", "4", "3", "2", "1"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFunctions()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupFunctions(){
        setupImageView()
        setupLetterLabel()
        setupNumberLabel()
    }

    private func setupLetterLabel(){
        CustomLabel.setupLabel(letterLabel, tintColor: .clear, textColor: .black, fontSize: 14, fontName: "Avenir-Medium")
        LayoutManager.anchor(childView: letterLabel, parentView: self,
                             bottom: bottomAnchor, paddingBottom: 0,
                             trailing: trailingAnchor, paddingTrailing: -2)
    }
    
    private func setupNumberLabel(){
        CustomLabel.setupLabel(numberLabel, tintColor: .clear, textColor: .black, fontSize: 13, fontName: "Avenir-Medium")
        LayoutManager.anchor(childView: numberLabel, parentView: self,
                             top: topAnchor, paddingTop: 2,
                             leading: leadingAnchor, paddingLeading: 2)
    }
    
    private func setupImageView(){
        LayoutManager.anchor(childView: pieceImage, parentView: self, 
                             top: topAnchor, paddingTop: 5,
                             leading: leadingAnchor, paddingLeading: 5,
                             bottom: bottomAnchor, paddingBottom: -5,
                             trailing: trailingAnchor, paddingTrailing: -5)
    }
    
    func configureCell(at indexPath: IndexPath) {
        let isEvenCell = (indexPath.row / 8 + indexPath.row % 8) % 2 == 0
        self.backgroundColor = isEvenCell ? ThemeManager.colorCode("F7DDB8", alpha: 1) : ThemeManager.colorCode("2A456D", alpha: 1)
        let textColor = isEvenCell ? ThemeManager.colorCode("2A456D", alpha: 1) : ThemeManager.colorCode("F7DDB8", alpha: 1)
        
        if indexPath.row >= 56 {
            let letterIndex = indexPath.row % 8
            letterLabel.text = letters[letterIndex]
            letterLabel.textColor = textColor
        }
        
        if indexPath.row % 8 == 0 {
            let numberIndex = indexPath.row / 8
            numberLabel.text = numbers[numberIndex]
            numberLabel.textColor = textColor
        }
    }
}
