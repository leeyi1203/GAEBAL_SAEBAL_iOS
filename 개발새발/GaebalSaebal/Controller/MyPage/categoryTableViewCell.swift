//
//  categoryTableViewCell.swift
//  GaebalSaebal
//
//  Created by 김가은 on 2022/05/13.
//

import UIKit
protocol ContentsMainTextDelegate: AnyObject {
    func categoryButtonTapped()
    
}
class categoryTableViewCell: UITableViewCell {
    
    var cellDelegate: ContentsMainTextDelegate?
    
    @IBOutlet weak var categoryButton: UIButton!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier) // 여기서 버튼에 액션 추
        self.categoryButton.addTarget(self, action: #selector(categoryClicked), for: .touchUpInside)
        self.categoryButton.isHidden=true
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.categoryClicked()
    }
    
    
//    let categoryButton: UIButton = {
//        let bt = UIButton()
//        bt.backgroundColor=UIColor.lightGray
//        return bt }() // 위임해줄 기능을 미리 구현해두어 버튼에 액션 추가
    
    @objc func categoryClicked() { cellDelegate?.categoryButtonTapped() }



   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
