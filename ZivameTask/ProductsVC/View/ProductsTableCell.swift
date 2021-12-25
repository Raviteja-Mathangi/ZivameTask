//
//  ProductsTableCell.swift
//  ZivameTask
//
//  Created by Raviteja Mathangi on 23/12/21.
//

import UIKit
import Cosmos
class ProductsTableCell: UITableViewCell {
    //MARK:- Outlets
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var specLbl: UILabel!
    @IBOutlet weak var rating:CosmosView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var cartBtn: UIButton!
    //MARK:-
    var productVar:ProductsViewModal!{
        didSet{
            guard let url = URL(string: (productVar.imageURL!)) else { return }
            UIImage.loadFrom(url: url) { image in
                self.productImage.image = image
            }
            self.getSpecifications(nameStr: productVar.name!)
            self.priceLbl.text = productVar.price
            self.rating.rating = Double(productVar.rating!)
        }
    }
    var fetchedProduct:ProductEntity!{
        didSet{
            guard let url = URL(string: (fetchedProduct.imageAtrbt!)) else { return }
            UIImage.loadFrom(url: url) { image in
                self.productImage.image = image
            }
            self.getSpecifications(nameStr: fetchedProduct.nameAtrbt!)
            self.priceLbl.text = fetchedProduct.priceAtrbt!
            self.rating.rating = Double(fetchedProduct.ratingAtrbt)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func getSpecifications(nameStr:String){
        let specStr = nameStr
        let specArray = specStr.components(separatedBy: "(")
        self.nameLbl.text = specArray[0]
        self.specLbl.text = specArray[1].replacingOccurrences(of: ")", with: "")
    }
}
