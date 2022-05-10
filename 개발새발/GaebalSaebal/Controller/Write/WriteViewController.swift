//
//  WriteViewController.swift
//  GaebalSaebal
//
//  Created by DOYEONLEE2 on 2022/04/07.
//

import UIKit

let categoryList = ["미정", "백준", "자료구조", "스터디"]

class WriteViewController: UIViewController {
    @IBOutlet weak var categoryStackView: UIStackView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //네비게이션 바 디자인
        customNavgationBar()
        
        //카테고리 버튼 생성
        self.addCategoryButton(categoryList: categoryList)
    }
    
    func customNavgationBar(){

        self.navigationController!.navigationBar.topItem?.backButtonTitle = "취소하기"
        self.navigationController!.navigationBar.tintColor = .gray
        
        let completeButton = UIBarButtonItem(title: "완료",
                                             style: .plain,
                                             target: self,
                                             action: nil)
        self.navigationController!.navigationItem.rightBarButtonItem = completeButton
        
    }
    
    
    func addCategoryButton(categoryList : [String]){
        for name in categoryList {
            let categoryItemButton = UIButton()
            categoryItemButton.setTitle(name, for: .normal)
            categoryItemButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            categoryItemButton.translatesAutoresizingMaskIntoConstraints = false
            categoryItemButton.tintColor = .blue
            categoryItemButton.setTitleColor(.gray, for: .normal)
            categoryItemButton.setTitleColor(.blue, for: .selected)
            categoryItemButton.layer.borderColor = UIColor.gray.cgColor
            categoryItemButton.layer.borderWidth = 1.5
            categoryItemButton.layer.cornerRadius = 15
            categoryItemButton.isEnabled = true
//            Button 여백 설정
            categoryItemButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 12, bottom: 2, right: 12)
            categoryItemButton.addTarget(self, action: #selector(clickCategoryButton(_:)), for: .touchUpInside)
            self.categoryStackView.addArrangedSubview(categoryItemButton)
        }
    }
    
    @objc func clickCategoryButton(_ sender: UIButton){
        print("button clicked! \(sender.titleLabel?.text)")
        sender.isSelected = sender.isSelected ? false : true
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
