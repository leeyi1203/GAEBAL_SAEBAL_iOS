//
//  WriteViewController.swift
//  GaebalSaebal
//
//  Created by DOYEONLEE2 on 2022/04/07.
//

import UIKit

let categoryList = ["미정", "백준", "자료구조", "스터디"]

class WriteViewController: UIViewController {

    //MARK: - ✅ Outlets & Actions
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var categoryStackView: UIStackView!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var tagTextView: UITextView!
    @IBOutlet weak var baekjoonView: UIView!
    @IBOutlet weak var githubView: UIView!
    
    @IBOutlet weak var imageAddView: UIView!
    @IBOutlet weak var codeTextView: UITextView!
    //MARK: - ✅ Variables
    let lighterGray = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1).cgColor
    
    let dashedBorderGray = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor

    let minBodyTextViewHeight : CGFloat = 128
    
    //MARK: - ✅ View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 스크롤뷰 제스터 추가 (터치 시 키보드 낼기)
        addScrollViewTapGuester()
        
        //텍스트필드 델리게이트
        self.bodyTextView.delegate = self
        self.tagTextView.delegate = self
        
        //네비게이션 바 디자인
        customNavgationBar()
        
        //카테고리 버튼 생성
        self.addCategoryButton(categoryList: categoryList)
        
        //본문, 태그 TextView 디자인
        customTextView(textView:self.bodyTextView, placeHolder:"본문을 입력해주세요", bgColor: UIColor.white.cgColor)
        customTextView(textView:self.tagTextView, placeHolder:"태그는 ;으로 구분해서 적어주세요. ex) 백준;", bgColor : UIColor.white.cgColor)
        customTextView(textView:self.codeTextView, placeHolder: "#include <stdio.h>", bgColor : lighterGray)
        
        //백준, 깃허브 버튼 디자인
        customViewButton(viewButton:baekjoonView, radius:baekjoonView.frame.height / 2)
        customViewButton(viewButton:githubView, radius:baekjoonView.frame.height / 2)
        customViewButton(viewButton : imageAddView,radius: CGFloat(15))
        
    }
    
    //MARK: - ✅ Custom Function
    
    func addScrollViewTapGuester(){
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapMethod))
//        singleTapGestureRecognizer.numberOfTapsRequired = 1
//        singleTapGestureRecognizer.isEnabled = true
//        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)

    }
    
    @objc func scrollViewTapMethod(sender: UITapGestureRecognizer) {
        print("scroll view taped")
        self.bodyTextView.resignFirstResponder()
        self.tagTextView.resignFirstResponder()
        }
    
    func customNavgationBar(){

        self.navigationController!.navigationBar.topItem?.backButtonTitle = "취소하기"
        self.navigationController!.navigationBar.tintColor = .gray
        
        //안됨
        let completeButton = UIBarButtonItem(title: "완료",
                                             style: .plain,
                                             target: self,
                                             action: nil)
        self.navigationController!.navigationItem.rightBarButtonItem = completeButton
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()

        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        
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
    
    // 본문, 태그, 코드 입력란 커스텀
    func customTextView(textView : UITextView, placeHolder : String, bgColor : CGColor){
        textView.layer.cornerRadius = 20
        textView.layer.backgroundColor = bgColor
        textView.layer.borderWidth = 1.5
        textView.layer.borderColor = lighterGray
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15);
        textView.text = placeHolder
    }
    
    
    // 백준, 깃허브 입력란 커스텀
    func customViewButton(viewButton: UIView, radius : CGFloat){
        //모서리 둥글게
        viewButton.layer.cornerRadius = viewButton.frame.height / 2
        
        // 점선 보더 설정
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = dashedBorderGray
        borderLayer.lineDashPattern = [5, 5]
        borderLayer.frame = view.bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: viewButton.bounds, cornerRadius: radius).cgPath
        
        viewButton.layer.addSublayer(borderLayer)
        
        // 플러스 이미지 넣기
        let plusImage = UIImage(named: "PlusIcon.png")
        let plusImageView = UIImageView(image: plusImage)
        plusImageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        viewButton.addSubview(plusImageView)
        plusImageView.translatesAutoresizingMaskIntoConstraints = false
        plusImageView.centerXAnchor.constraint(equalTo:viewButton.centerXAnchor).isActive = true
        plusImageView.centerYAnchor.constraint(equalTo:viewButton.centerYAnchor).isActive = true
    }
    
    
    


}

//MARK: - ✅ Text View Extension

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
//        self.view.frame.size.height += textView.frame.width
        
    }

    
}
