//
//  categoryTableViewCell.swift
//  GaebalSaebal
//
//  Created by 김가은 on 2022/05/13.
//

import UIKit
protocol AddCategoryDelegate {
    func AddCategory()
}

class categoryTableViewCell: UITableViewCell {
    
    
    var cellDelegate : AddCategoryDelegate?
    
    @IBOutlet weak var categoryButton: UIButton!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.categoryButton.isHidden=true

    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    @objc func plusbtnClicked(sender:UIGestureRecognizer){
        cellDelegate?.AddCategory()


    }

   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(plusbtnClicked(sender:)))
        categoryButton.addGestureRecognizer(tapGesture)
    }

}
