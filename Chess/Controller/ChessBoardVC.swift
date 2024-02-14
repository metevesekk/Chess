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
    
    private func setupTapGestureRecognizer(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        collectionView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer){
        let location = gesture.location(in: collectionView)
        
        guard let indexPath = collectionView.indexPathForItem(at: location),
              let cell = collectionView.cellForItem(at: indexPath)else { return }
        cell.backgroundColor = UIColor.fromHex("4abfa5")
        cell.layer.borderWidth = cell.bounds.width/15
        cell.layer.borderColor = UIColor.fromHex("94e5d3").cgColor
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: collectionView)
        
        switch gesture.state {
        case .began:
            guard let indexPath = collectionView.indexPathForItem(at: location),
                  let cell = collectionView.cellForItem(at: indexPath) as? ChessBoardCell,
                  let snapshot = cell.pieceImage.snapshotView(afterScreenUpdates: true) else { return }
            
            resetCellsAppearanceExceptSelected()
            self.draggingIndexPath = indexPath
            let frame = collectionView.convert(cell.pieceImage.frame, from: cell)
            snapshot.frame = frame
            collectionView.addSubview(snapshot)
            snapshot.center = location
            draggingView = snapshot
            initialCenter = snapshot.center
            cell.pieceImage.isHidden = true
            
            cell.backgroundColor = UIColor.fromHex("4abfa5")
            cell.layer.borderWidth = cell.bounds.width/15
            cell.layer.borderColor = UIColor.fromHex("94e5d3").cgColor
            
            
        case .changed:
            guard let draggingView = draggingView else { return }
            
            let translation = gesture.translation(in: collectionView)
            let newCenter = CGPoint(x: initialCenter!.x + translation.x, y: initialCenter!.y + translation.y)
            draggingView.center = newCenter

            keepSnapshotWithinBoardBounds()
            
        case .ended, .cancelled:
            guard let draggingIndexPath = draggingIndexPath,
                  let cell = collectionView.cellForItem(at: draggingIndexPath) as? ChessBoardCell else { return }
            
            cell.pieceImage.isHidden = false
            
            draggingView?.removeFromSuperview()
            self.draggingIndexPath = nil
            self.draggingView = nil
            self.initialCenter = nil
           
        default:
            break
        }
    }
    
    private func resetCellsAppearanceExceptSelected() {
        for i in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: i, section: 0)
            if let cell = collectionView.cellForItem(at: indexPath) as? ChessBoardCell, indexPath != draggingIndexPath {
                cell.backgroundColor = cell.color
                cell.layer.borderColor = cell.borderColor.cgColor
            }
        }
    }

    private func keepSnapshotWithinBoardBounds() {
        guard let draggingView = draggingView else { return }
        
        let minX = draggingView.frame.width / 2
        let maxX = collectionView.frame.width - minX
        let minY = draggingView.frame.height / 2
        let maxY = collectionView.frame.height - minY
        
        var newCenter = draggingView.center
        newCenter.x = max(minX, min(newCenter.x, maxX))
        newCenter.y = max(minY, min(newCenter.y, maxY))
        
        draggingView.center = newCenter
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        resetCellsAppearanceExceptSelected()
        cell.backgroundColor = UIColor.fromHex("4abfa5")
        cell.layer.borderWidth = cell.bounds.width/15
        cell.layer.borderColor = UIColor.fromHex("94e5d3").cgColor
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ChessBoardCell else { return }
        cell.backgroundColor = cell.color
        cell.layer.borderColor = cell.borderColor.cgColor
    }
}
