//
//  GithubRepoTableViewCell.swift
//  GaebalSaebal
//
//  Created by DOYEONLEE2 on 2022/05/16.
//

import UIKit

class GithubEventTableViewCell: UITableViewCell {
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    
    
    let greenLabelColor = UIColor.init(red: 77/255, green: 168/255, blue: 86/255, alpha: 1)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customTypeLabel()
        eventTitle.text = "UI 깨짐 해결하기"
        
        setupLayout()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
    func customTypeLabel(){
        typeLabel.layer.borderWidth = 1.5
        typeLabel.layer.borderColor = greenLabelColor.cgColor
        typeLabel.textColor = greenLabelColor
        typeLabel.layer.cornerRadius = typeLabel.frame.height / 2
    }
    
    func setupLayout() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.clipsToBounds = false
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 12
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.white
        
        self.contentView.layer.cornerRadius = self.contentView.frame.height / 2
        self.contentView.layer.masksToBounds = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.frame = self.layer.frame.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
            
        self.contentView.frame.size.width -= 40
            

    }

}
