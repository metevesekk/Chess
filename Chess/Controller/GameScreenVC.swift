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
    var offsetSize: CGFloat = -60
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

    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let boardSize = view.bounds.width * 0.9
        layout.itemSize = CGSize(width: boardSize / 8, height: boardSize / 8)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        let xOffset = (view.bounds.width - boardSize) / 2
        let yOffset = (view.bounds.height - boardSize) / 2 + offsetSize
        collectionView = UICollectionView(frame: CGRect(x: xOffset, y: yOffset, width: boardSize, height: boardSize), collectionViewLayout: layout)
        
        collectionView.register(ChessBoardCell.self, forCellWithReuseIdentifier: "ChessBoardCell")
        collectionView.dataSource = self
        collectionView.delegate = self

        view.addSubview(collectionView)
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
