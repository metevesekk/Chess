//
//  ChessBoardVC.swift
//  Chess
//
//  Created by Mete Vesek on 13.02.2024.
//

import UIKit

class ChessBoardVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var board : Board!
    var draggingIndexPath: IndexPath?
    var draggingView: UIView?
    var initialCenter: CGPoint?
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFunctions()
        self.view.backgroundColor = .black
    }
    
    func setupFunctions(){
        setupCollectionView()
        setupBoard()
        setupPanGestureRecognizer()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let boardSize = min(view.bounds.width, view.bounds.height) * 0.9
        layout.itemSize = CGSize(width: boardSize / 8, height: boardSize / 8)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: boardSize, height: boardSize), collectionViewLayout: layout)
        collectionView.register(ChessBoardCell.self, forCellWithReuseIdentifier: "ChessBoardCell")
        collectionView.dataSource = self
        collectionView.delegate = self

        view.addSubview(collectionView)
    }


    
    func setupBoard(){
        board = Board()
    }
    
    private func setupPanGestureRecognizer() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        collectionView.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: collectionView)

        switch gesture.state {
        case .began:
            guard let indexPath = collectionView.indexPathForItem(at: location),
                  let cell = collectionView.cellForItem(at: indexPath) as? ChessBoardCell else { return }
            
            self.draggingIndexPath = indexPath
            let snapshot = cell.pieceImage.snapshotView(afterScreenUpdates: true)!
            // cell.pieceImage.frame'i collectionView'ın koordinat sistemine göre dönüştür
            let frame = collectionView.convert(cell.pieceImage.frame, from: cell)
            snapshot.frame = frame
            collectionView.addSubview(snapshot)
            draggingView = snapshot
            initialCenter = snapshot.center
            
            // Orijinal hücreyi gizleyin (opsiyonel)
            cell.pieceImage.isHidden = true
            
        case .changed:
            guard let draggingView = draggingView, let initialCenter = initialCenter else { return }
            let translation = gesture.translation(in: collectionView)
            draggingView.center = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
            
        case .ended, .cancelled:
            guard let draggingIndexPath = draggingIndexPath else { return }
            if let cell = collectionView.cellForItem(at: draggingIndexPath) as? ChessBoardCell {
                // Orijinal hücreyi tekrar göster
                cell.isHidden = false
                cell.pieceImage.isHidden = false
            }
            
            // Sürüklenen görünümü kaldır
            draggingView?.removeFromSuperview()
            self.draggingIndexPath = nil
            self.draggingView = nil
            self.initialCenter = nil
           
        default:
            break
        }
    }
}

extension ChessBoardVC{
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
