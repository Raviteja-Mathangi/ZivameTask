//
//  Service.swift
//  ZivameTask
//
//  Created by Raviteja Mathangi on 24/12/21.
//

import Foundation
class Service: NSObject {
    static let shared = Service()
    
    func fetchProducts(completion: @escaping ([Product]?, Error?) -> ()) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: "https://my-json-server.typicode.com/nancymadan/assignment/db")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                print ("error: \(error!)")
                return
            }
            guard let content = data else {
                print("No data")
                return
            }
            guard let jsonData = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("error occured in responseData")
                return
            }
            do {
                let dataObject = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
                let products = try JSONDecoder().decode(Products.self, from: dataObject)
                DispatchQueue.main.async {
                    completion(products.products, nil)
                }
            } catch let error {
                print("error" , error)
            }
        }
        task.resume()
    }
}
