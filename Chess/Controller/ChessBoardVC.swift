//
//  ChessBoardVC.swift
//  Chess
//
//  Created by Mete Vesek on 24.11.2023.
//

import UIKit

class ChessBoardVC: UIViewController {
    var collectionView: UICollectionView!
    var leadingSize: CGFloat = 15
    var centerYAnchorOffset: CGFloat = -20

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.bounds.width - leadingSize) / 8, height: (view.bounds.width - leadingSize) / 8)
        layout.minimumInteritemSpacing = 0 // CGFloat türünde olmalıdır
        layout.minimumLineSpacing = 0 // CGFloat türünde olmalıdır
        layout.sectionInset = UIEdgeInsets.zero // Bölüm içi boşlukları kaldır
        

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(ChessCell.self, forCellWithReuseIdentifier: "ChessCell")
        collectionView.layer.borderColor = UIColor.systemYellow.cgColor
        collectionView.layer.borderWidth = 4
        let borderSize = collectionView.layer.borderWidth
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false // Eğer AutoLayout kullanacaksanız

        view.addSubview(collectionView)
        
        // AutoLayout kısıtlamalarını etkinleştir
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalToConstant: view.bounds.width - leadingSize),
            collectionView.widthAnchor.constraint(equalToConstant: view.bounds.width - leadingSize),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: centerYAnchorOffset)
        ])
    }


}

extension ChessBoardVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 64 // Satranç tahtası 8x8'dir, toplamda 64 hücre
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChessCell", for: indexPath) as! ChessCell
        cell.configureCell(at: indexPath)
        return cell
    }

    // Diğer delegate metotları...
}
