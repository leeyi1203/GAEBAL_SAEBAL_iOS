//
//  WriteViewController.swift
//  GaebalSaebal
//
//  Created by DOYEONLEE2 on 2022/04/07.
//

import UIKit
//import JSONDecoder



let categoryList = ["미정", "백준", "자료구조", "스터디", "ㅁㄴㅁㅇㄹㄴㅇ"]


class WriteViewController: UIViewController, SendSelectedGithubEventDelegate {

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
    var navigationbarWriteButton: UIButton! = nil;
    
    let lighterGray = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1).cgColor
    
    var categoryButtonList: [UIButton] = []
    
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
    
    var selectedGithubEvent: Event? = nil
    var selectedRepoOwner: String? = nil
    var selectedRepoName: String? = nil
    
    let mainPink = UIColor(red: 250/255, green: 0/255, blue: 255/255, alpha: 1)
    let mainPurple = UIColor(red: 178/255, green: 14/255, blue: 255/255, alpha: 1)

    
    //MARK: - ✅ View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 상속된 write 버튼 없애기
        removeNagationBarWriteButton()
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        /// button bounds가 view가 다 그려졌을 때 바인딩되는 것 같다... 그래서 그라데이션 보더는 뷰가 다 나타나고 지정해줘야한다,,,
        // 일단 미정 버튼 활성화
        self.categoryButtonList[0].isSelected = true
        setButtonGradientBorder(button: self.categoryButtonList[0])
    }
    
    override func viewWillDisappear(_ animated: Bool) {

    }
    
    //MARK: - ✅ Custom Function
    
    //키보드 올라갔다는 알림을 받으면 실행되는 메서드
    @objc func keyboardWillShow(_ sender:Notification){
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            // ⚠️ 아....... 이거 해결해야함
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
   
    // 상속된 write 버튼 없애기
    func removeNagationBarWriteButton(){
        self.navigationController!.navigationBar.subviews.forEach{
            if ( $0 is UIImageView ) {
                $0.isHidden = true
                navigationbarWriteButton = $0 as? UIButton
            }
        }
    }
    
    func customNavgationBar(){
        
        // navbar 수정
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
    
    func addCategoryButton(categoryList: [String]){
        for name in categoryList {
            let categoryItemButton = UIButton()
            
            // 일반설정
            categoryItemButton.setTitle(name, for: .normal)
            categoryItemButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//            categoryItemButton.translatesAutoresizingMaskIntoConstraints = false
            categoryItemButton.setTitleColor(.gray, for: .normal)
            categoryItemButton.setTitleColor(mainPurple, for: .selected)
            categoryItemButton.layer.borderColor = UIColor.gray.cgColor
            categoryItemButton.layer.borderWidth = 1.5
            categoryItemButton.layer.cornerRadius = 15
            categoryItemButton.isEnabled = true
            
            // Button 여백 설정
            categoryItemButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 12, bottom: 2, right: 12)
            categoryItemButton.addTarget(self, action: #selector(clickCategoryButton(_:)), for: .touchUpInside)
            
            
            self.categoryStackView.addArrangedSubview(categoryItemButton)
            self.categoryButtonList.append(categoryItemButton)
        }


    }
    
    func setButtonGradientBorder(button: UIButton){
        // 버튼 그라데이션 도저어어어어어어언
        
        let borderWidth: CGFloat = 1.5
        
        button.backgroundColor = UIColor.clear
        button.layoutIfNeeded()
        button.layer.borderColor = UIColor.clear.cgColor
        
        // 그라디언트 배경(레이어) 생성
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = button.bounds
        gradientLayer.colors = [mainPurple.cgColor,
                                mainPink.cgColor]
        
        // 그라디언트 레이어를 border 모양으로 잘라줌
        let shape = CAShapeLayer()
        shape.lineWidth = borderWidth
        //보더만큼 Rect 사이즈를 조정해줘야한다. lineWidth가 1.5이니까 크기는 -3씩, 위치는 1.5씩 이동
        shape.path = UIBezierPath(roundedRect: CGRect(x: borderWidth,
                                                      y: borderWidth,
                                                      width: button.bounds.width - borderWidth * 2,
                                                      height: button.bounds.height - borderWidth * 2), cornerRadius: 15).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradientLayer.mask = shape
        
        // 서브레이어 추가
        button.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func removeButtonGradientBorder(button: UIButton){
        button.layer.sublayers?.forEach {
            if ($0 is CAGradientLayer){
                $0.removeFromSuperlayer()
            }
        }
        button.layer.borderColor = UIColor.gray.cgColor
    }

    
    @objc func clickCategoryButton(_ sender: UIButton){
        sender.isSelected = true
        setButtonGradientBorder(button: sender)
        for button in categoryButtonList{
            if ( button == sender ){
                continue
            }
            
            if button.isSelected{
                button.isSelected = false
                removeButtonGradientBorder(button: button)
            }
        }
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
        
        // 보더 초기화
        viewButton.layer.borderWidth = 0
        viewButton.layer.borderColor = UIColor.clear.cgColor
        
        // 버튼 뷰 초기화
        viewButton.subviews.forEach({ $0.removeFromSuperview() })
        viewButton.layer.sublayers?.forEach({ $0.removeFromSuperlayer() })
        
        // 탭 이벤트 삭제
        if (viewButton.gestureRecognizers?.count != 0){
            if let removeTargetGesture = viewButton.gestureRecognizers?[0] {
                viewButton.removeGestureRecognizer(removeTargetGesture)
            } else { print("tap gesture is nil") }
        }

        
        if (isUsed){
            if viewButton == self.baekjoonView{
                setUsedBeakjoonView(viewButton: viewButton)
            }
            else{
                setUsedGithubView(viewButton: viewButton)
            }
        }
        // 사용 전(초기) / 취소 일시 UI
        else{
            // 점선 보더 설정
            let borderLayer = CAShapeLayer()
            borderLayer.strokeColor = dashedBorderGray
            borderLayer.lineDashPattern = [5, 5]
            borderLayer.frame = view.bounds
            borderLayer.fillColor = nil
            borderLayer.path = UIBezierPath(roundedRect: viewButton.bounds, cornerRadius: radius).cgPath
            
            viewButton.layer.addSublayer(borderLayer)
            
            // 플러스 이미지 넣기
            let plusImage = UIImage(named: "PlusIcon.svg")
            let plusImageView = UIImageView(image: plusImage)
            plusImageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            viewButton.addSubview(plusImageView)
            plusImageView.translatesAutoresizingMaskIntoConstraints = false
            plusImageView.centerXAnchor.constraint(equalTo:viewButton.centerXAnchor).isActive = true
            plusImageView.centerYAnchor.constraint(equalTo:viewButton.centerYAnchor).isActive = true
            plusImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
            plusImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true

            // 탭 이벤트 추가
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapViewButtonForAdd(sender:)))
            viewButton.addGestureRecognizer(tapGesture)

        }
    }
    
    func setUsedBeakjoonView(viewButton: UIView){
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
        cancelIconImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cancelIconImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        // 탭 이벤트 (취소) 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapViewButtonForCancel(sender:)))
        cancelIconImageView.addGestureRecognizer(tapGesture)
        cancelIconImageView.isUserInteractionEnabled = true
    }
    
    func setUsedGithubView(viewButton: UIView){
        if self.selectedGithubEvent != nil{
            viewButton.layer.borderColor = lighterGray
            viewButton.layer.borderWidth = 1.5
            
            let typeLabel:UILabel = {
                let label = UILabel()
                
                let greenLabelColor = UIColor.init(red: 77/255, green: 168/255, blue: 86/255, alpha: 1)
                let blueLabelColor = UIColor.init(red: 48/255, green: 141/255, blue: 181/255, alpha: 1)
                let redLabelColor = UIColor.init(red: 185/255, green: 54/255, blue: 54/255, alpha: 1)
                
                var labelColor:UIColor?
                
                // type 라벨 설정 (이슈인지, 풀인지, 커밋인지)
                switch ( self.selectedGithubEvent?.type){
                case "issue":
                    label.text = "    issue    "
                    labelColor = redLabelColor
                case "pull request":
                    label.text = "    pull requeset    "
                    labelColor = blueLabelColor
                    
                default:
                    label.text = "    commit    "
                    labelColor = greenLabelColor
                }
                
                label.layer.borderWidth = 2
                
                // 라벨 컬러 변경
                label.layer.borderColor = labelColor?.cgColor
                label.textColor = labelColor
                
                // 텍스트 크기 조정
                label.font = UIFont.boldSystemFont(ofSize: 13.0)

                return label
                }()
                
                // type label 추가하고 제약 설정
                viewButton.addSubview(typeLabel)
                typeLabel.translatesAutoresizingMaskIntoConstraints = false
                typeLabel.topAnchor.constraint(equalTo: viewButton.topAnchor, constant: 15).isActive = true
                typeLabel.leadingAnchor.constraint(equalTo: viewButton.leadingAnchor, constant: 35).isActive = true
                // 라벨 높이 설정
                let typeLabelHeight: CGFloat = 23
                typeLabel.heightAnchor.constraint(equalToConstant: typeLabelHeight).isActive = true
                // 모서리 둥글게
                typeLabel.layer.cornerRadius = typeLabelHeight / 2
                
                let eventTitle: UILabel = {
                    let title = UILabel()
                    
                    title.text = self.selectedGithubEvent?.title
                    // 텍스트 크기 조정
                    title.font = UIFont.boldSystemFont(ofSize: 16.0)
                    
                    return title
                }()
                
                // title label 추가하고 제약 설정
                viewButton.addSubview(eventTitle)
                eventTitle.translatesAutoresizingMaskIntoConstraints = false
                eventTitle.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 8).isActive = true
                eventTitle.leadingAnchor.constraint(equalTo: viewButton.leadingAnchor, constant: 38).isActive = true
                eventTitle.trailingAnchor.constraint(equalTo: viewButton.trailingAnchor, constant: -45).isActive = true
            
            // 폴더 이미지 넣기
            let folderImage: UIImageView = {
                let image = UIImage(named: "file_icon.png")
                let imageView = UIImageView(image: image)
                imageView.frame = CGRect(x: 0, y: 0, width: 15, height: 13)
                
                return imageView
            }()
            
            viewButton.addSubview(folderImage)
            folderImage.translatesAutoresizingMaskIntoConstraints = false
            folderImage.topAnchor.constraint(equalTo: eventTitle.bottomAnchor, constant: 7).isActive = true
            folderImage.leadingAnchor.constraint(equalTo: viewButton.leadingAnchor, constant: 38).isActive = true
            
            
            // 레포명 넣기
            let repoNameLable: UILabel = {
                let label = UILabel()
                
                label.text = "\(self.selectedRepoOwner ?? "")/\(self.selectedRepoName ?? "")"
                label.font = UIFont.systemFont(ofSize: 13)
                label.textColor = UIColor.gray
                
                return label
            }()
            
            viewButton.addSubview(repoNameLable)
            repoNameLable.translatesAutoresizingMaskIntoConstraints = false
            repoNameLable.topAnchor.constraint(equalTo: eventTitle.bottomAnchor, constant: 6).isActive = true
            repoNameLable.leadingAnchor.constraint(equalTo: folderImage.trailingAnchor, constant: 8).isActive = true
            repoNameLable.widthAnchor.constraint(equalToConstant: 200).isActive = true
            
            //날짜 넣기
            let eventDateLabel:UILabel = {
                let label = UILabel()
                
                let changedDate = changeDateFormat(dateStr: self.selectedGithubEvent!.created_at)
                label.text = changedDate
                label.font = UIFont.systemFont(ofSize: 13)
                label.textColor = UIColor.gray
                
                return label
            }()
            
            viewButton.addSubview(eventDateLabel)
            eventDateLabel.translatesAutoresizingMaskIntoConstraints = false
            eventDateLabel.topAnchor.constraint(equalTo: viewButton.topAnchor, constant: 15).isActive = true
            eventDateLabel.trailingAnchor.constraint(equalTo: viewButton.trailingAnchor, constant: -38).isActive = true
            
            // 취소(삭제) 아이콘 추가
            let cancelIconImage = UIImage(named: "cancelIcon")
            let cancelIconImageView = UIImageView(image: cancelIconImage)
            viewButton.addSubview(cancelIconImageView)
            cancelIconImageView.translatesAutoresizingMaskIntoConstraints = false
            cancelIconImageView.centerYAnchor.constraint(equalTo: viewButton.centerYAnchor).isActive = true
            cancelIconImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
            cancelIconImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
            cancelIconImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
            
            // 탭 이벤트 (취소) 추가
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapViewButtonForCancel(sender:)))
            cancelIconImageView.addGestureRecognizer(tapGesture)
            cancelIconImageView.isUserInteractionEnabled = true
            
        }//if문 end
        
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
            performSegue(withIdentifier: "showGithubRepoListView", sender: githubView)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "showGithubRepoListView" {
               let viewController : GithubReposViewController = segue.destination as! GithubReposViewController
                   viewController.delegate = self
           }
       }
    
    @objc func tapViewButtonForCancel(sender:UIGestureRecognizer){
        if (sender.view == self.baekjoonView){
            print("백준 취소 버튼 실행")
            customViewButton(viewButton: self.baekjoonView, radius: self.baekjoonView.frame.height / 2, isUsed: false)
        }
        else{
            customViewButton(viewButton: self.githubView, radius: self.githubView.frame.height / 2, isUsed: false)
        }
    }
    
    func sendGithubEvent(event: Event, selectedRepoOwner: String, selectedRepoName: String){
        print("####\(event) 전달 완료")
        self.selectedGithubEvent = event
        self.selectedRepoOwner = selectedRepoOwner
        self.selectedRepoName = selectedRepoName
        // UI update
        customViewButton(viewButton: self.githubView,
                         radius: self.githubView.frame.height / 2,
                         isUsed: true)
    }
    
    func changeDateFormat(dateStr: String) -> String{

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'" // 2020-08-13 16:30
                
        let convertDate = dateFormatter.date(from: dateStr) // Date 타입으로 변환
                
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy.MM.dd a hh:mm" // 2020.08.13 오후 04시 30분
        let convertStr = myDateFormatter.string(from: convertDate!)
        
        return convertStr
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
