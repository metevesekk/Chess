//
//  GameScreenVC.swift
//  Chess
//
//  Created by Mete Vesek on 7.02.2024.
//

import UIKit

class GameScreenVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var collectionView: UICollectionView!
    var paddingSize: CGFloat = 50
    var offsetSize: CGFloat = -50

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()

        view.backgroundColor = #colorLiteral(red: 0.9594381452, green: 0.9594381452, blue: 0.9594381452, alpha: 1)
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.bounds.width - paddingSize) / 8, height: (view.bounds.width - paddingSize) / 8)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0 
        layout.sectionInset = UIEdgeInsets.zero

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(ChessBoardCell.self, forCellWithReuseIdentifier: "ChessBoardCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        LayoutHelper.anchor(childView: collectionView, parentView: view, width: view.bounds.width - paddingSize, heigth: view.bounds.width - paddingSize, centerX: view.centerXAnchor, centerY: view.centerYAnchor, paddingCenterY: offsetSize)
    }

}

extension GameScreenVC{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 64
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChessBoardCell", for: indexPath) as! ChessBoardCell
        cell.configureCell(at: indexPath)
        return cell
    }
}
