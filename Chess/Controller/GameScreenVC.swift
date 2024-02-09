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
    var button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupButton()
        view.backgroundColor = ThemeManager.colorCode("fdf8ec", alpha: 1)
    }

    func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.bounds.width - paddingSize) / 8, height: (view.bounds.width - paddingSize) / 8)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0 
        layout.sectionInset = UIEdgeInsets.zero

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(ChessBoardCell.self, forCellWithReuseIdentifier: "ChessBoardCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        LayoutManager.anchor(childView: collectionView, parentView: view, width: view.bounds.width - paddingSize, heigth: view.bounds.width - paddingSize, centerX: view.centerXAnchor, centerY: view.centerYAnchor, paddingCenterY: offsetSize)
    }
    
    func setupButton(){
        CustomButton.setupButton(button, backgroundColor: ThemeManager.colorCode("e46290", alpha: 1) , tintColor: .white, textColor: .white, fontSize: 20, fontName: "TimesNewRomanPS-BoldMT", title: "Hello", cornerRadius: 5, bordorColor: CGColor(srgbRed: 0.5, green: 0.6, blue: 0.7, alpha: 1) , borderWidth: 5)
        LayoutManager.anchor(childView: button, parentView: view, width: 70 , heigth: 40, centerX: view.centerXAnchor, centerY: view.centerYAnchor)
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
