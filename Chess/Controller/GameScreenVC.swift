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
    var label = UILabel()
    var board : Board!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.fromHex("fdf8ec")
        setupFunctions()
    }
    
    func setupFunctions(){
        setupCollectionView()
        setupGestureRecognizer()
        board = Board()
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
        CustomButton.setupButton(button, backgroundColor: UIColor.fromHex("e46290") , tintColor: .white, textColor: .white, fontSize: 20, fontName: "TimesNewRomanPS-BoldMT", title: "Hello", cornerRadius: 5, bordorColor: CGColor(srgbRed: 0.5, green: 0.6, blue: 0.7, alpha: 1) , borderWidth: 5)
        LayoutManager.anchor(childView: button, parentView: view, width: 70 , heigth: 40, centerX: view.centerXAnchor, centerY: view.centerYAnchor)
    }
    
    func setupLabel(){
        CustomLabel.setupLabel(label, tintColor: .black, textColor: UIColor.fromHex("a46290"), fontSize: 15, fontName: "TimesNewRoman", text: "Burası da Label", cornerRadius: 7)
        LayoutManager.anchor(childView: label, parentView: view, centerX: view.centerXAnchor, centerY: view.centerYAnchor, paddingCenterY: 40)
    }
    
    func setupGestureRecognizer(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        collectionView.addGestureRecognizer(gesture)
    }
    
    @objc func handleTap(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: collectionView)
        
        if let indexPath = collectionView.indexPathForItem(at: location) {
            let cell = collectionView.cellForItem(at: indexPath) as? ChessBoardCell
            print("Dokunulan hücrenin indexPath'i: \(indexPath)")
            let isCellEmpty = cell?.pieceImage.image == nil
            print(isCellEmpty ? "Hücre Boş" : "Hücrede bir taş var")
        } else {
            print("CollectionView dışında bir yere dokunuldu.")
        }
    }

    

}

extension GameScreenVC{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 64
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChessBoardCell", for: indexPath) as! ChessBoardCell
        cell.configureCell(at: indexPath)
        let piece = board.pieces[indexPath.row]
        cell.configurePiece(with: piece)
        return cell
    }

}
