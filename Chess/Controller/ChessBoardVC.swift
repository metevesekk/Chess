//
//  ChessBoardVC.swift
//  Chess
//
//  Created by Mete Vesek on 13.02.2024.
//

import UIKit

class ChessBoardVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: GLOBAL PROPERTIES
    
    var board : Board!
    var draggingIndexPath: IndexPath?
    var draggingView: UIView?
    var initialCenter: CGPoint?
    var collectionView: UICollectionView!
    
    // MARK: VIEWDIDLOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFunctions()
        self.view.backgroundColor = .black
    }
    
    // MARK: SETUP FUNCTIONS
    
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
    
    
    // MARK: RECOGNIZER FUNCTIONS
    
    private func setupPanGestureRecognizer() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        collectionView.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: collectionView)
        
        switch gesture.state {
        case .began:
            guard let indexPath = collectionView.indexPathForItem(at: location),
                  let cell = collectionView.cellForItem(at: indexPath) as? ChessBoardCell,
                  let snapshot = cell.pieceImage.snapshotView(afterScreenUpdates: true) else { return }
            
            selectCell(at: indexPath)
            self.draggingIndexPath = indexPath
            let frame = collectionView.convert(cell.pieceImage.frame, from: cell)
            snapshot.frame = frame
            collectionView.addSubview(snapshot)
            snapshot.center = location
            draggingView = snapshot
            initialCenter = snapshot.center
            cell.pieceImage.isHidden = true
            
            
        case .changed:
            guard let indexPath = collectionView.indexPathForItem(at: initialCenter!),
                  let draggingView = draggingView else { return }
            
            selectCell(at: indexPath)
            let translation = gesture.translation(in: collectionView)
            let newCenter = CGPoint(x: initialCenter!.x + translation.x, y: initialCenter!.y + translation.y)
            draggingView.center = newCenter

            
            keepSnapshotWithinBoardBounds()
            
        case .ended, .cancelled:
                guard let draggingIndexPath = draggingIndexPath,
                      let draggingView = draggingView,
                      let sourceCell = collectionView.cellForItem(at: draggingIndexPath) as? ChessBoardCell else {
                    return
                }

                let targetLocation = collectionView.convert(draggingView.center, to: collectionView)
                guard let targetIndexPath = collectionView.indexPathForItem(at: targetLocation),
                      let targetCell = collectionView.cellForItem(at: targetIndexPath) as? ChessBoardCell else {
                    resetDraggingItemToInitialPosition(draggingView: draggingView, sourceCell: sourceCell)
                    return
                }

                if targetCell.markImageView.isHidden {
                    resetDraggingItemToInitialPosition(draggingView: draggingView, sourceCell: sourceCell)
                } else {
                    finishDraggingItem(draggingView: draggingView, sourceIndexPath: draggingIndexPath, targetIndexPath: targetIndexPath, sourceCell: sourceCell, targetCell: targetCell)
                }

           
        default:
            break
        }
    }
    
    
    
    // MARK: EXTRA FUNCTIONS
    
    private func finishDraggingItem(draggingView: UIView, sourceIndexPath: IndexPath, targetIndexPath: IndexPath, sourceCell: ChessBoardCell, targetCell: ChessBoardCell) {
        UIView.animate(withDuration: 0.2, animations: {
            draggingView.center = targetCell.center
        }) { [weak self] _ in
            sourceCell.pieceImage.removeFromSuperview()
            draggingView.removeFromSuperview()
           
            
            self?.board.movePiece(from: sourceIndexPath, to: targetIndexPath)

            targetCell.configurePiece(with: self?.board.pieces[targetIndexPath.row])
            self?.clearAllMarks()
            self?.resetColor(cell: sourceCell, indexPath: sourceIndexPath)
            self?.resetDraggingState()
        }
    }

    private func resetDraggingState() {
        draggingIndexPath = nil
        draggingView = nil
        initialCenter = nil
    }

    private func resetDraggingItemToInitialPosition(draggingView: UIView, sourceCell: ChessBoardCell) {
        UIView.animate(withDuration: 0.2, animations: {
            draggingView.center = self.initialCenter ?? sourceCell.center
        }) { _ in
            draggingView.removeFromSuperview()
            sourceCell.pieceImage.isHidden = false
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
    
    private func setColor(cell: ChessBoardCell, indexPath: IndexPath){
        resetCellsAppearanceExceptSelected()
        cell.backgroundColor = UIColor.fromHex("4abfa5")
        cell.layer.borderWidth = cell.bounds.width/15
        cell.layer.borderColor = UIColor.fromHex("94e5d3").cgColor
    }
    
    private func resetColor(cell: ChessBoardCell, indexPath: IndexPath){
        cell.backgroundColor = cell.color
        cell.layer.borderColor = cell.borderColor.cgColor
    }
    
    private func setMark(cell: ChessBoardCell, indexPath: IndexPath){
        if let piece = self.board.pieces[indexPath.row] {
            
            let possibleMoves = Move().possibleMoves(with: piece, from: indexPath, on: board)
            for cell in collectionView.visibleCells.compactMap({ $0 as? ChessBoardCell }) {
                cell.showMark(false)
            }
            for moveIndexPath in possibleMoves {
                if let moveCell = collectionView.cellForItem(at: moveIndexPath!) as? ChessBoardCell {
                    moveCell.showMark(true)
                }
            }
        } else{
            for cell in collectionView.visibleCells.compactMap({ $0 as? ChessBoardCell }) {
                cell.showMark(false)
            }
        }
    }
    
    private func clearAllMarks() {
        for cell in collectionView.visibleCells.compactMap({ $0 as? ChessBoardCell }) {
            cell.showMark(false)
        }
    }
    
    private func selectCell(at indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ChessBoardCell else { return }
        setColor(cell: cell, indexPath: indexPath)
        setMark(cell: cell, indexPath: indexPath)
    }
}

// MARK: EXTENSION

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
        
        UIView.animate(withDuration: 0.15){
            self.selectCell(at: indexPath)
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ChessBoardCell else { return }
        resetColor(cell: cell, indexPath: indexPath)
    }
}
