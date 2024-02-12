//
//  GameScreenVC.swift
//  Chess
//
//  Created by Mete Vesek on 7.02.2024.
//

import UIKit

class GameScreenVC: UIViewController {
    
    
    var collectionView: UICollectionView!
    var offsetSize: CGFloat = -60
    var chessBoardVC = ChessBoardVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.fromHex("fdf8ec")
        setupFunctions()
    }
    
    func setupFunctions(){
        setupChessBoardVC()
    }
    
    func setupChessBoardVC() {
        chessBoardVC = ChessBoardVC()
        addChild(chessBoardVC)
        view.addSubview(chessBoardVC.view)
        let boardSize = view.bounds.width * 0.9
        
        let xOffset = (view.bounds.width - boardSize) / 2
        let yOffset = (view.bounds.height - boardSize) / 2 + offsetSize
        chessBoardVC.view.frame = CGRect(x: xOffset, y: yOffset, width: boardSize, height: boardSize)
        chessBoardVC.didMove(toParent: self)

    }
}

