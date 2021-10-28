//
//  SelectedProductViewController.swift
//  EBSInternshipApp
//
//  Created by Rauh Andrei on 26.10.2021.
//

import UIKit

class SelectedProductViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Constants
    var dataToShow: [ProductData]?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    //MARK: - Configure
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.collectionView.register(UINib(nibName:"ProductInfoCell", bundle: nil), forCellWithReuseIdentifier: ProductInfoCell.identifier)
    }
}


//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SelectedProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataToShow?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductInfoCell.identifier, for: indexPath) as! ProductInfoCell
        cell.configure(with: dataToShow![indexPath.row])
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SelectedProductViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = collectionView.bounds.height
        
        return CGSize(width: width, height: height)
    }
}
