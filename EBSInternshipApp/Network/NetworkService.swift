//
//  NetworkService.swift
//  EBSInternshipApp
//
//  Created by Rauh Andrei on 21.10.2021.
//

import Foundation

protocol NetworkServiceType {
    func loadData(completion: @escaping (Result<[ProductData], NetworkError>) -> Void)
}

class NetworkService: NetworkServiceType {
    
    //MARK: - Constants
    private let session: URLSession
    private let url = URL(string: "http://mobile-shop-api.hiring.devebs.net/products")
    
    init(session: URLSession) {
        self.session = session
    }
    
    func loadData(completion: @escaping (Result<[ProductData], NetworkError>) -> Void) {
        let request = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.url))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.hasSuccessStatusCode,let data = data
            else {
                completion(.failure(.network))
                return
            }
            
            do {
                let resultData = try JSONDecoder().decode(Root.self, from: data)
                let newData = resultData.results
                completion(.success(newData))
            } catch {
                completion(.failure(.decoding))
            }
        }.resume()
    }
}
