//
//  GithubRepoTableViewCell.swift
//  GaebalSaebal
//
//  Created by DOYEONLEE2 on 2022/05/17.
//

import UIKit

class GithubRepoTableViewCell: UITableViewCell {
    @IBOutlet weak var repoNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupLayout()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
