//
//  ProductsVC.swift
//  ZivameTask
//
//  Created by Raviteja Mathangi on 23/12/21.
//

import UIKit
import CoreData
import AVFoundation
import AudioToolbox
class ProductsVC: UIViewController {
    var isServiceLoading: Bool = true{
        didSet{
            self.productsTable.reloadData()
        }
    }
    var productsVM : [[ProductsViewModal]]?
    @IBOutlet weak var productsTable:UITableView!
    @IBOutlet weak var cartLbl: UILabel!
    var cartItems:[ProductEntity]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        loadProducts()
    }
    //MARK:- API Calling method
    func getData(){
        Service.shared.fetchProducts{ [weak self] (productsList, error) in
            if let err = error {
                print("Failed to fetch products:", err)
                return
            }
            let sourceList = productsList?.map({return ProductsViewModal(productInit: $0)}) ?? []
            self?.productsVM =  self?.filterModal(source: sourceList)
            if let _ = self?.productsVM{
                DispatchQueue.main.async {
                    self?.isServiceLoading = false
                }
            }
        }
    }
    //MARK:- Check for data if it is in coredata
    func loadProducts(){
        do {
            self.cartItems = try context.fetch(ProductEntity.fetchRequest())
            DispatchQueue.main.async {
                self.cartLbl.backgroundColor =  self.cartItems!.count > 0 ? .red : .clear
                self.cartLbl.text = String(self.cartItems!.count)
            }
        }  catch {
            fatalError("failed to fetch")
        }
    }
    //MARK:- Move to cart screen
    @IBAction func cartButtonAction(_ sender: Any){
        let cartVC = self.storyboard?.instantiateViewController(withIdentifier: "CartVC") as! CartVC
        self.navigationController?.pushViewController(cartVC, animated: true)
    }
    //MARK:- ReArrange multi-dimentional array from array of dictionaries
    func filterModal(source:[ProductsViewModal])->([[ProductsViewModal]]){
        var result = [[ProductsViewModal]]()
        let filtered = source.filter{ Int($0.price!)! < 10000  }
        let morethan = source.filter{ Int($0.price!)! > 10000 }
        result.append(filtered)
        result.append(morethan)
        return result
    }
    //MARK:- Add to cart action
    @objc func cartBtnAction(sender:UIButton){
        let row = sender.tag % 1000
        let section = sender.tag / 1000
        print("section \(section) @and indexPath: \(row)")
        addData(viewModal: productsVM![section][row])
    }
    //MARK:- Check for duplicate entries in coredata
    func isEntityAttributeExist(entityName: String, name:String) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "nameAtrbt == %@", name)
        let res = try! managedContext.fetch(fetchRequest)
        return res.count > 0 ? true : false
    }
    //MARK:-Add data to Entity
    func addData(viewModal: ProductsViewModal){
        if !isEntityAttributeExist(entityName: "ProductEntity", name: viewModal.name!){
            let product = ProductEntity(context: context)
            product.nameAtrbt = viewModal.name!
            product.imageAtrbt = viewModal.imageURL!
            product.priceAtrbt = viewModal.price!
            product.ratingAtrbt = Int64(viewModal.rating!)
            do {
                try self.context.save()
                self.playSystemSound()
                self.loadProducts()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }else{
            print("Product already saved")
        }
    }
    
}
//MARK:- Table view delegate and data source 
extension ProductsVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return isServiceLoading ? 2 : self.productsVM!.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return isServiceLoading ? 5 : self.productsVM![section].count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label = UILabel()
        label.frame = CGRect.init(x: 20, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        headerView.backgroundColor = .white
        label.text = section == 0 ? "Products less than 10000 price" : "Products more than 10000 price"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        headerView.addSubview(label)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.productsTable.dequeueReusableCell(withIdentifier: "ProductsTableCell", for: indexPath) as! ProductsTableCell
        if isServiceLoading{
            cell.contentView.showLoading()
        }else{
            cell.contentView.hideLoading()
            cell.cartBtn.tag = (indexPath.section * 1000) + indexPath.row
            cell.cartBtn.addTarget(self, action: #selector(cartBtnAction(sender:)), for: .touchUpInside)
            cell.productVar = self.productsVM![indexPath.section][indexPath.row]
        }
        return cell
    }
}
