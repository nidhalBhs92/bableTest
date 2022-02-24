//
//  CityItemCell.swift
//  MyForcast
//
//  Created by Nidhal on 21/2/2022.
//

import UIKit

protocol CityItemCellDelegate: AnyObject {
    func onClickItemCell(model: ResultCity?)
}

class CityItemCell: UITableViewCell {
    
    static let nibName: String = "CityItemCell"
    
    @IBOutlet weak var lbNameCity: UILabel!
    @IBOutlet weak var lbNameDesc: UILabel!
    
    weak var delegate: CityItemCellDelegate?

    var model: ResultCity?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        print("test")
        }
    func initView(model: ResultCity) {
        self.model = model
        if let first = model.areaName.first {
            self.lbNameCity.text = first.value
        }
        if let first = model.country.first {
            self.lbNameDesc.text = first.value
        }
        
        self.contentView.setOnClickListener(target: self, action: #selector(onClickCell))
    }
    
    @objc func onClickCell(_ tap: UITapGestureRecognizer) {
        self.delegate?.onClickItemCell(model: self.model)
    }
    
    /*
        get Nib of Cell
     */
    static func nib() -> UINib {
        return UINib(nibName: CityItemCell.nibName, bundle: nil)
    }
}
