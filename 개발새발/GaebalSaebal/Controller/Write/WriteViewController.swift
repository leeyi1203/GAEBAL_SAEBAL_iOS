//
//  WriteViewController.swift
//  GaebalSaebal
//
//  Created by DOYEONLEE2 on 2022/04/07.
//

import UIKit

let categoryList = ["미정", "백준", "자료구조", "스터디"]

class WriteViewController: UIViewController {

    ///✅ Outlets & Actions
    @IBOutlet weak var categoryStackView: UIStackView!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var tagTextView: UITextView!
    @IBOutlet weak var backjoonView: UIView!
    
    ///✅ Variables
    let lighterGray = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1).cgColor

    let minBodyTextViewHeight : CGFloat = 128
    
    ///✅ View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //텍스트필드 델리게이트
        self.bodyTextView.delegate = self
        self.tagTextView.delegate = self
        
        //네비게이션 바 디자인
        customNavgationBar()
        
        //카테고리 버튼 생성
        self.addCategoryButton(categoryList: categoryList)
        
        //TextView 디자인
        customTextView(textView:self.bodyTextView, placeHolder:"본문을 입력해주세요")
        customTextView(textView:self.tagTextView, placeHolder:"태그는 ;으로 구분해서 적어주세요. ex) 백준;")
        
        //백준 버튼 디자인
        customBaekjoonButton()
        

        
    }
    
    ///✅ Custom Function
    
    func customNavgationBar(){

        self.navigationController!.navigationBar.topItem?.backButtonTitle = "취소하기"
        self.navigationController!.navigationBar.tintColor = .gray
        
        //안됨
        let completeButton = UIBarButtonItem(title: "완료",
                                             style: .plain,
                                             target: self,
                                             action: nil)
        self.navigationController!.navigationItem.rightBarButtonItem = completeButton
        
    }
    
    func customTextView(textView : UITextView, placeHolder : String){
        textView.layer.cornerRadius = 20
        textView.layer.borderWidth = 1.5
        textView.layer.borderColor = lighterGray
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15);
        textView.text = placeHolder
    }
    
    @IBInspectable var dashWidth: CGFloat = 0
    @IBInspectable var dashColor: UIColor = .clear
    @IBInspectable var dashLength: CGFloat = 0
    @IBInspectable var betweenDashesSpace: CGFloat = 0
    
    var dashBorder: CAShapeLayer?
    
    func customBaekjoonButton(){
        backjoonView.layer.cornerRadius = backjoonView.frame.height / 2
        backjoonView.layer.borderWidth = 1.5
        backjoonView.layer.borderColor = lighterGray
        
        
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = dashWidth
        dashBorder.strokeColor = dashColor.cgColor
        dashBorder.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]
        dashBorder.frame = backjoonView.bounds
        dashBorder.fillColor = nil
        
//        backjoonView.addSublayer(dashBorder)
        self.dashBorder = dashBorder
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
            //Button 여백 설정
            categoryItemButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 12, bottom: 2, right: 12)
            categoryItemButton.addTarget(self, action: #selector(clickCategoryButton(_:)), for: .touchUpInside)
            self.categoryStackView.addArrangedSubview(categoryItemButton)
        }
    }
    
    @objc func clickCategoryButton(_ sender: UIButton){
        print("button clicked! \(sender.titleLabel?.text)")
        sender.isSelected = sender.isSelected ? false : true
        
    }

}

extension WriteViewController: UITextViewDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //텍스트필드 외 뷰 터치시 키보드 내리기
        self.bodyTextView.resignFirstResponder()
        self.tagTextView.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
//        textViewList.map{ $0.becomeFirstResponder() }
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        let textViewWidth = textView.frame.width
        textView.translatesAutoresizingMaskIntoConstraints = true
        textView.sizeToFit()
        //sizeToFit이 width도 fit 시키기 때문에 기억해둔 Width로 재조정한다
        textView.frame.size.width = textViewWidth
        // 최소 높이 이하 일땐 height를 최소높이로 재조정한다
        if (textView.frame.size.height < minBodyTextViewHeight) {
            textView.frame.size.height = minBodyTextViewHeight
        }
        textView.isScrollEnabled = false
        self.view.frame.size.height += textView.frame.width
        
    }

    
}
