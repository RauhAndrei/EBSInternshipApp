//
//  ViewPresenter.swift
//  EBSInternshipApp
//
//  Created by Rauh Andrei on 21.10.2021.
//

import UIKit

protocol ViewControllerDelegate: AnyObject {
    func loadData(on viewController: ProductsViewControllerType)
}

class ViewPresenter: ViewControllerDelegate {
    let networkService: NetworkServiceType
    
    init(network: NetworkServiceType) {
        self.networkService = network
    }
    
    func loadData(on viewController: ProductsViewControllerType) {
        DispatchQueue.global().async {
            self.networkService.loadData { result in
                DispatchQueue.main.async {
                    self.handleResult(result, on: viewController)
                }
            }
        }
    }
    
    func handleResult(_ result: Result<[ProductData], NetworkError>,
                      on viewController: ProductsViewControllerType) {
        switch result {
        case let .failure(error):
            viewController.showAlert(with: error)

        case let .success(data):
            viewController.update(with: data)
        }
    }
}
