//
//  WriteViewController.swift
//  GaebalSaebal
//
//  Created by DOYEONLEE2 on 2022/04/07.
//

import UIKit
//import JSONDecoder

let categoryList = ["미정", "백준", "자료구조", "스터디"]

class WriteViewController: UIViewController {

    //MARK: - ✅ Outlets & Actions
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var categoryStackView: UIStackView!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var bodyTextCountLabel: UILabel!
    @IBOutlet weak var tagTextView: UITextView!
    @IBOutlet weak var baekjoonView: UIView!
    @IBOutlet weak var githubView: UIView!
    
    @IBOutlet weak var imageAddView: UIView!
    @IBOutlet weak var codeTextView: UITextView!
    //MARK: - ✅ Variables
    let lighterGray = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1).cgColor
    
    let dashedBorderGray = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor

    let minBodyTextViewHeight:CGFloat = 128
    let minTagTextViewHeight:CGFloat = 50
    let minCodeTextViewHeight:CGFloat = 128
    
    
    let defaultScrollViewHeight:CGFloat = 1096
    
    let bodyTextViewPlaceHolder = "본문을 입력해주세요"
    let tagTextViewPlaceHolder = "태그는 ;으로 구분해서 적어주세요. ex) 백준;"
    let codeTextViewPlaceHolder = "ex) #include <stdio.h>"
    
    var keyboardHeight:CGFloat = 0
    
    let bojLink:String = ""
    
    //MARK: - ✅ View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 스크롤뷰 제스터 추가 (터치 시 키보드 낼기)
        addScrollViewTapGuester()
        
        //텍스트필드 델리게이트
        self.bodyTextView.delegate = self
        self.tagTextView.delegate = self
        self.codeTextView.delegate = self
        
        //네비게이션 바 디자인
        customNavgationBar()
        
        //카테고리 버튼 생성
        self.addCategoryButton(categoryList: categoryList)
        
        //본문, 태그 TextView 디자인
        customTextView(textView:self.bodyTextView, placeHolder:bodyTextViewPlaceHolder, bgColor: UIColor.white.cgColor)
        customTextView(textView:self.tagTextView, placeHolder:tagTextViewPlaceHolder, bgColor: UIColor.white.cgColor)
        customTextView(textView:self.codeTextView, placeHolder: codeTextViewPlaceHolder, bgColor: lighterGray)
        
        //백준, 깃허브 버튼 디자인
        customViewButton(viewButton:baekjoonView, radius:baekjoonView.frame.height / 2, isUsed: false)
        customViewButton(viewButton:githubView, radius:baekjoonView.frame.height / 2, isUsed: false)
        customViewButton(viewButton:imageAddView, radius: CGFloat(15), isUsed: false)
        
        // 키보드가 텍스트필드 가리지 않도록 옵저버 설정
        NotificationCenter.default.addObserver(self,
                                                selector: #selector(keyboardWillHide(_:)),
                                                name: UIResponder.keyboardWillHideNotification,
                                                object: nil)
        NotificationCenter.default.addObserver(self,
                                                selector: #selector(keyboardWillShow(_:)),
                                                name: UIResponder.keyboardWillShowNotification,
                                                object: nil)
        
    }
    
    //MARK: - ✅ Custom Function
    
    //키보드 올라갔다는 알림을 받으면 실행되는 메서드
    @objc func keyboardWillShow(_ sender:Notification){
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y = -keyboardHeight
        }
    }
    //키보드 내려갔다는 알림을 받으면 실행되는 메서드
    @objc func keyboardWillHide(_ sender:Notification){
            self.view.frame.origin.y = 0
    }
    
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
        self.codeTextView.resignFirstResponder()
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
        textView.textColor = .gray
    }
    
    
    
    // 백준, 깃허브 입력란 커스텀
    func customViewButton(viewButton: UIView, radius: CGFloat, isUsed: Bool){
        //모서리 둥글게
        viewButton.layer.cornerRadius = viewButton.frame.height / 2
        
        // 버튼 뷰 초기화
        viewButton.subviews.forEach({ $0.removeFromSuperview() })
        viewButton.layer.sublayers?.forEach({ $0.removeFromSuperlayer() })
        // 탭 이벤트 삭제
        if let removeTargetGesture = viewButton.gestureRecognizers?[0] {
            viewButton.removeGestureRecognizer(removeTargetGesture)
        }

        //사용 전 / 취소 일시 UI
        if (isUsed == false){
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

            // 탭 이벤트 추가
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapViewButtonForAdd(sender:)))
            viewButton.addGestureRecognizer(tapGesture)
        }
        else{
            
            // 보더 설정
            viewButton.layer.borderWidth = 1.5
            viewButton.layer.borderColor = lighterGray
            
            // 백준 아이콘 추가
            let bojLogoImage = UIImage(named: "bojLogo")
            let bojLogoImageView = UIImageView(image: bojLogoImage)
            viewButton.addSubview(bojLogoImageView)
            bojLogoImageView.translatesAutoresizingMaskIntoConstraints = false
            bojLogoImageView.centerYAnchor.constraint(equalTo: viewButton.centerYAnchor).isActive = true
            bojLogoImageView.leftAnchor.constraint(equalTo: view.leftAnchor
                    , constant: 40).isActive = true // 왼쪽여백
            
            // 취소(삭제) 아이콘 추가
            let cancelIconImage = UIImage(named: "cancelIcon")
            let cancelIconImageView = UIImageView(image: cancelIconImage)
            viewButton.addSubview(cancelIconImageView)
            cancelIconImageView.translatesAutoresizingMaskIntoConstraints = false
            cancelIconImageView.centerYAnchor.constraint(equalTo: viewButton.centerYAnchor).isActive = true
            cancelIconImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
            
            // 탭 이벤트 (취소) 추가
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapViewButtonForCancel(sender:)))
            cancelIconImageView.addGestureRecognizer(tapGesture)
            cancelIconImageView.isUserInteractionEnabled = true
            
        }
    }
    
    @objc func tapViewButtonForAdd(sender:UIGestureRecognizer){
        // 백준 뷰 클릭시 실행할 동작
        if(sender.view == self.baekjoonView){
            let alert = UIAlertController(title: "백준 문제 번호 입력", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default){ _ in
                print(alert.textFields?[0].text ?? "")
                self.customViewButton(viewButton: self.baekjoonView, radius: self.baekjoonView.frame.height / 2, isUsed: true)
            }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            alert.addTextField()
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
        else if (sender.view == self.githubView){
            performSegue(withIdentifier: "showGithubEventListView", sender: githubView)
        }
    }
    
    @objc func tapViewButtonForCancel(sender:UIGestureRecognizer){
        if (sender.view == self.baekjoonView){
            print("백준 취소 버튼 실행")
            customViewButton(viewButton: self.baekjoonView, radius: self.baekjoonView.frame.height / 2, isUsed: false)
        }
    }

}

//MARK: - ✅ Text View Extension

extension WriteViewController: UITextViewDelegate {
    
    // 이 메소드는 스크롤 뷰에서는 동작안함
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        //텍스트필드 외 뷰 터치시 키보드 내리기
//        self.bodyTextView.resignFirstResponder()
//        self.tagTextView.resignFirstResponder()
//        self.codeTextView.resignFirstResponder()
//
//    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // 사용자가 아무것도 입력하지 않은 상태 (플레이스 홀더가 보이는 상태) 이면 텍스트 뷰 비우고 텍스트 색 변경
        if textView.textColor == .gray {
            textView.text = ""
            textView.textColor = .black
        }
        
        textView.becomeFirstResponder()
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text.count == 0) {
            if (textView == bodyTextView) {
                textView.text = bodyTextViewPlaceHolder
            }
            else if (textView == tagTextView) {
                textView.text = tagTextViewPlaceHolder
            }
            else if (textView == codeTextView) {
                textView.text = codeTextViewPlaceHolder
            }
            textView.textColor = .gray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        // 텍스트 뷰 가변 높이 설정
        let minViewHeight:CGFloat = {
            switch textView {
            case self.bodyTextView:
                return minBodyTextViewHeight
            case self.tagTextView:
                return minTagTextViewHeight
            case self.codeTextView:
                return minCodeTextViewHeight
            default:
                return 100
            }
        }()

        let textViewWidth = textView.frame.width
        textView.translatesAutoresizingMaskIntoConstraints = true
        textView.sizeToFit()
        //sizeToFit이 width도 fit 시키기 때문에 기억해둔 Width로 재조정한다
        textView.frame.size.width = textViewWidth
        // 본문 텍스트뷰가 최소 높이 이하 일땐 height를 최소높이로 재조정한다
        if (textView.frame.size.height < minViewHeight) {
            textView.frame.size.height = minViewHeight
        }
        
        // 스토리보드 constraint를 없앴기 때문에 다시 설정
        /// -> 하려고 했지만 translatesAutoresizingMaskIntoConstraints ture 인 상태에서 제약조건이 먹히지 않는다.
        /// -> 따라서 그냥 절대좌표를 일일이 계산해준다 후후
        /// 레전드 하드코딩
        self.tagTextView.frame.origin.y = /* 카테고리뷰 topAnchor */ CGFloat(25) + /* 카테고리뷰 height */30 + /* 카테고리뷰 본문 bottomAnchor */25 + /* bodyTextView height */ self.bodyTextView.frame.height + /* tag label topAnchor */ 25 + /* tag label height */ 17 + /* tag label bottomAnchor */ 10
        // codeTextView 도 마찬가지 대충 계산함.
        self.codeTextView.frame.origin.y = self.imageAddView.frame.origin.y + self.imageAddView.frame.height + 25 + 17 + 10
            
        //본문 글자 수 세기
        if (textView == self.bodyTextView){
            self.bodyTextCountLabel.text = "\(bodyTextView.text.count)/1000"
        }
        
        // 텍스트 뷰가 길이가 길어진 상태일 경우 scroll view 높이도 조정
        textView.isScrollEnabled = false
        self.scrollView.contentSize.height = defaultScrollViewHeight + self.bodyTextView.frame.height - minBodyTextViewHeight + self.tagTextView.frame.height - minTagTextViewHeight + self.codeTextView.frame.height - minCodeTextViewHeight
    }

    
}

