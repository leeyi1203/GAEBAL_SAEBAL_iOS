//
//  SettingTableViewCell.swift
//  GaebalSaebal
//
//  Created by 김가은 on 2022/05/09.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var Content_View: UIView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        Content_View.layer.borderWidth=0.5
        Content_View.layer.cornerRadius=10
        Content_View.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
