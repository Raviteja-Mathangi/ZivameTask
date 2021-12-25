//
//  CartVC.swift
//  ZivameTask
//
//  Created by Raviteja Mathangi on 24/12/21.
//

import UIKit
import CoreData

class CartVC: UIViewController {
    @IBOutlet weak var cartTable: UITableView!
    var cartItems:[ProductEntity]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var isFetching:Bool = true{
        didSet{
            self.cartTable.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProducts()
    }
    //MARK:- getProducts from coreData
    func loadProducts(){
        do {
            self.cartItems = try context.fetch(ProductEntity.fetchRequest())
            DispatchQueue.main.async {
                self.isFetching = false
            }
        }  catch {
            fatalError("failed to fetch")
        }
    }
    //MARK:- Move to next screen
    @IBAction func moveToCheckout(_ sender: Any){
        let checkoutVC =  self.storyboard?.instantiateViewController(withIdentifier: "CheckoutVC") as! CheckoutVC
        self.navigationController?.pushViewController(checkoutVC, animated: true)
    }
}
//MARK:- TableView delegate and data source
extension CartVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return isFetching ? 5 : self.cartItems!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.cartTable.dequeueReusableCell(withIdentifier: "ProductsTableCell", for: indexPath) as! ProductsTableCell
        if isFetching{
            cell.contentView.showLoading()
        }else{
            cell.contentView.hideLoading()
            let product = self.cartItems![indexPath.row]
            cell.fetchedProduct = product
        }
        return cell
    }
}

