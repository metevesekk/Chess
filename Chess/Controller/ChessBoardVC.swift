//
//  ChessBoardVC.swift
//  Chess
//
//  Created by Mete Vesek on 24.11.2023.
//

import UIKit

class ChessBoardVC: UIViewController {
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width / 8, height: view.bounds.width / 8)
        layout.minimumInteritemSpacing = 0 // CGFloat türünde olmalıdır
        layout.minimumLineSpacing = 0 // CGFloat türünde olmalıdır
        layout.sectionInset = UIEdgeInsets.zero // Bölüm içi boşlukları kaldır

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(ChessCell.self, forCellWithReuseIdentifier: "ChessCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false // Eğer AutoLayout kullanacaksanız

        view.addSubview(collectionView)
        
        // AutoLayout kısıtlamalarını etkinleştir
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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



