//
//  ViewController.swift
//  EBSInternshipApp
//
//  Created by Rauh Andrei on 18.10.2021.
//

import UIKit

protocol ProductsViewControllerType {
    func showAlert(with error: NetworkError)
    func update(with data: [ProductData])
}

class ProductsViewController: UIViewController, ProductsViewControllerType {
    
    //MARK: - Variables
    var data: [ProductData] = []
    var data1: [ProductData] = []
    
    var presenter: ViewControllerDelegate?
    
    private var isGridLayout: Bool = false
    
    // MARK: - Outlets
    @IBOutlet private weak var listButton: UIButton!
    @IBOutlet private weak var gridButton: UIButton!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var filterButton: UILabel!
    @IBOutlet weak var myCartButton: UIButton!
    @IBOutlet weak var countOfCart: UILabel!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
        assemblePresenter()
        presenter?.loadData(on: self)
        configureFonts()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func assemblePresenter() {
        let networkService = NetworkService(session: URLSession.shared)
        let presenter = ViewPresenter(network: networkService)
        self.presenter = presenter
    }
    
    //MARK: - ProductsViewControllerType implementation
    func showAlert(with error: NetworkError) {
        let alert = UIAlertController(title: "Error", message: error.errorDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func update(with data: [ProductData]) {
        self.data = data
        collectionView.reloadData()
    }
    
    //MARK: - Configure
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.collectionView.register(UINib(nibName:"ProductCell", bundle: nil), forCellWithReuseIdentifier: ProductCell.identifier)
    }
    
    func configureFonts() {
        myCartButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 13)
        filterButton.font = UIFont(name: "OpenSans-Semibold", size: 12)
        myCartButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 13)
    }
    
    //MARK: - Actions
    @IBAction private func listButtonTap(_ sender: Any) {
        isGridLayout = false
        collectionView.reloadData()
    }
    
    @IBAction private func gridButtonTap(_ sender: Any) {
        isGridLayout = true
        collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let vc = segue.destination as! SelectedProductViewController
        vc.dataToShow = data1
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        let dataItem = data[indexPath.row]
        cell.configure(with: dataItem)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? ProductCell)?.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dataItem = data[indexPath.row]
        data1.removeAll()
        data1.append(dataItem)
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    //moved to ViewController1
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        let dataItem = data[indexPath.row]
    //        print(data[indexPath.row])
    //        let productInfoCell = collectionView.cellForItem(at: indexPath) as? ProductInfoCell
    ////        print(dataItem)
    //        productInfoCell!.configure1(with: dataItem)
    //
    //        performSegue(withIdentifier: "segue", sender: self)
    //    }
    
    
    //    func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell? { }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        if isGridLayout {
            return CGSize(width: width / 2 - 1, height: 206)
        }
        return CGSize(width: width, height: 206)
    }
}

//////////
extension ProductsViewController: ProductCellDelegate {
    
    func cellDidTappedLikeButton(_ cell: ProductCell) {
        guard let cellIndexPath = collectionView.indexPath(for: cell) else { return }
        //достать data и выгрузить в database
        let dataItem = data[cellIndexPath.row]
        //сохранить в базу данных
        
        //        data1.append(dataItem)
    }
    
    func cellDidTappedCartButton(_ cell: ProductCell) {
        
    }
    
    
}