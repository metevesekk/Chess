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
    var color = UIColor()
    var borderColor = UIColor()
    
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
        CustomLabel.setupLabel(letterLabel, tintColor: .clear, textColor: .black, fontSize: self.bounds.width/4, fontName: "Avenir-Heavy")
        LayoutManager.anchor(childView: letterLabel, parentView: self,
                             bottom: bottomAnchor, paddingBottom: 2,
                             trailing: trailingAnchor, paddingTrailing: -3)
    }
    
    private func setupNumberLabel(){
        CustomLabel.setupLabel(numberLabel, tintColor: .clear, textColor: .black, fontSize: self.bounds.width/4, fontName: "Avenir-Heavy")
        LayoutManager.anchor(childView: numberLabel, parentView: self,
                             top: topAnchor, paddingTop: 3,
                             leading: leadingAnchor, paddingLeading: 3)
    }
    
    private func setupImageView(){
            LayoutManager.anchor(childView: pieceImage, parentView: self,
                                 top: topAnchor, paddingTop: self.bounds.width/8,
                                 leading: leadingAnchor, paddingLeading: self.bounds.width/8,
                                 bottom: bottomAnchor, paddingBottom: -self.bounds.width/8,
                                 trailing: trailingAnchor, paddingTrailing: -self.bounds.width/8)
    }
    
    func configureCell(at indexPath: IndexPath) {
        let isEvenCell = (indexPath.row / 8 + indexPath.row % 8) % 2 == 0
        self.backgroundColor = isEvenCell ? UIColor.fromHex("F7DDB8") :  UIColor.fromHex("4679c3")
        let textColor = isEvenCell ? UIColor.fromHex("4679c3") :  UIColor.fromHex("F7DDB8")
        
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
        
        color = self.backgroundColor ?? .white
        borderColor = UIColor(cgColor: CGColor(gray: 1, alpha: 0))
    }
    
    func configurePiece(with piece: Piece?){
        if let piece = piece{
            let imageName = "\(piece.type)-\(piece.color)"
            pieceImage.image = UIImage(named: imageName)
        } else {
            pieceImage.image = nil
        }
    }
}
