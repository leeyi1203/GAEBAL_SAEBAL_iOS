//
//  DetailViewController.swift
//  GaebalSaebal
//
//  Created by 김가은 on 2022/04/30.
//

import UIKit
import SafariServices
import SwiftUI
protocol EditLogDelegate : class {
    func goEditLog(name : String ,section_row : Int)
}

class DetailViewController: UIViewController, UIContextMenuInteractionDelegate {
    // 수정,삭제 버튼
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (_: [UIMenuElement]) -> UIMenu? in
                    
                    let btn1 = UIAction(title: "수정", image: UIImage(systemName: "")) { (UIAction) in
                                                print("수정 클릭됨")
                        
                        //수정 버튼 누르면 디테일 페이지 사라지고,goEditLog()이용해서 카테고리 디테일 페이지에서 수정 페이지로 이동
                        self.goEditLogDelegate?.goEditLog(name: self.category_name,section_row: self.log_cate_id)
                        self.dismiss(animated: true)

                       
                        
                    }
                    let btn2 = UIAction(title: "삭제", image: UIImage(systemName: "")) { (UIAction) in
                        print("삭제 클릭됨")
                        let alert = UIAlertController(title: "기록 삭제", message: "기록을 삭제하시겠습니까?", preferredStyle: .alert)

                                let ok = UIAlertAction(title: "OK", style: .default) { (ok) in

                                    //DB에서 삭제하는 기능 추가
                                   //삭제 완료 알림
                                    let D_alert = UIAlertController(title: "삭제 완료", message: "삭제가 완료되었습니다.", preferredStyle: .alert)
                                    D_alert.addAction(ok)

                                    self.present(D_alert, animated: true, completion: nil)
                    
                                }

                                let cancel = UIAlertAction(title: "cancel", style: .cancel) { (cancel) in

                                     //code

                                }

                                alert.addAction(cancel)

                                alert.addAction(ok)

                                self.present(alert, animated: true, completion: nil)
                    }
                    
                    return UIMenu(children: [btn1,btn2])
                }
    }
    // MARK: - Declaration
    var goEditLogDelegate : EditLogDelegate?
    
    var DetailData : Int = 0
    @IBOutlet weak var D_title: UILabel!
    @IBOutlet weak var D_contents: UIView!
    @IBOutlet weak var D_body: UITextView!
    @IBOutlet weak var D_tag: UILabel!
    @IBOutlet weak var D_date: UILabel!
    @IBOutlet weak var contexMenu: UIView!
    @IBOutlet weak var contents_label: UILabel!
    @IBOutlet weak var ed_button: UIButton!
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var D_img: UIImageView!
    @IBOutlet weak var git_type_view: UIView!
    @IBOutlet weak var git_repo: UILabel!
    @IBOutlet weak var git_Date: UILabel!
    @IBOutlet weak var git_type: UILabel!
    @IBOutlet weak var git_label: UILabel!
    @IBOutlet weak var git_contents: UIView!
    //temporary data
    var git_link=""
    let gitRepoName="/DeeeeeepBlue/Mate-List"
    var category_name = "백준"
    var log_cate_id = 2
    var boj_link = ""
    var Github_num = "385732af"
    var Github_title = "디테일 페이지 완료"
    var Github_type = "Commit"
    var Github_date = "2022-03-24 15:30PM"
    var Github_repo = "13wjdgk/GaebalSaebal"
    let body_ex = "dsfdsafadsfjdasfdasjfkndasfnadsnfjkadshfjkahdsjkfhjalksdfhjkadfhjkladhfjkadshjkfadshjklfhadsjklfhjkldasfhjklasdhjfkhasjlkfhjsadkfhjklsdahfjklsdahljkfhsdjklafhjkldsahfjkldsahjkfsahdjkfhladjskhflkjasdhfjklsdahljkfhkjsdlfhkljsdhfkhdskljfhdskhfklsdhfkladhkfjahdsklfhadksjfhkdashfklsdahfkjshdajkfshdajklfhdsaljkfhsdaljkhfjdksahfljkadshfljkadshfjkdshfjklahjkfhadjkfhaslkfhladksfhlakdsjhflkjsdahfjkasdhfjklhdsfjkladshkfjhadskjfhasdkhfklajdshfkjladshfkjladshfjklhadskfjhadsfhdjksadsfdsafadsfjdasfdasjfkndasfnadsnfjkadshfjkahdsjkfhjalksdfhjkadfhjkladhfjkadshjkfadshjklfhadsjklfhjkldasfhjklasdhjfkhasjlkfhjsadkfhjklsdahfjklsdahljkfhsdjklafhjkldsahfjkldsahjkfsahdjkfhladjskhflkjasdhfjklsdahljkfhkjsdlfhkljsdhfkhdskljfhdskhfklsdhfkladhkfjahdsklfhadksjfhkdashfklsdahfkjshdajkfshdajklfhdsaljkfhsdaljkhfjdksahfljkadshfljkadshfjkdshfjklahjkfhadjkfhaslkfhladksfhlakdsjhflkjsdahfjkasdhfjklhdsfjkladshkfjhadskjfhasdkhfklajdshfkjladshfkjladshfjklhadskfjhadsfhdjksadsfdsafadsfjdasfdasjfkndasfnadsnfjkadshfjkahdsjkfhjalksdfhjkadfhjkladhfjkadshjkfadshjklfhadsjklfhjkldasfhjklasdhjfkhasjlkfhjsadkfhjklsdahfjklsdahljkfhsdjklafhjkldsahfjkldsahjkfsahdjkfhladjskhflkjasdhfjklsdahljkfhkjsdlfhkljsdhfkhdskljfhdskhfklsdhfkladhkfjahdsklfhadksjfhkdashfklsdahfkjshdajkfshdajklfhdsaljkfhsdaljkhfjdksahfljkadshfljkadshfjkdshfjklahjkfhadjkfhaslkfhladksfhlakdsjhflkjsdahfjkasdhfjklhdsfjkladshkfjhadskjfhasdkhfklajdshfkjladshfkjladshfjklhadskfjhadsfhdjksadsfdsafadsfjdasfdasjfkndasfnadsnfjkadshfjkahdsjkfhjalksdfhjkadfhjkladhfjkadshjkfadshjklfhadsjklfhjkldasfhjklasdhjfkhasjlkfhjsadkfhjklsdahfjklsdahljkfhsdjklafhjkldsahfjkldsahjkfsahdjkfhladjskhflkjasdhfjklsdahljkfhkjsdlfhkljsdhfkhdskljfhdskhfklsdhfkladhkfjahdsklfhadksjfhkdashfklsdahfkjshdajkfshdajklfhdsaljkfhsdaljkhfjdksahfljkadshfljkadshfjkdshfjklahjkfhadjkfhaslkfhladksfhlakdsjhflkjsdahfjkasdhfjklhdsfjkladshkfjhadskjfhasdkhfklajdshfkjladshfkjladshfjklhadskfjhadsfhdjksadsfdsafadsfjdasfdasjfkndasfnadsnfjkadshfjkahdsjkfhjalksdfhjkadfhjkladhfjkadshjkfadshjklfhadsjklfhjkldasfhjklasdhjfkhasjlkfhjsadkfhjklsdahfjklsdahljkfhsdjklafhjkldsahfjkldsahjkfsahdjkfhladjskhflkjasdhfjklsdahljkfhkjsdlfhkljsdhfkhdskljfhdskhfklsdhfkladhkfjahdsklfhadksjfhkdashfklsdahfkjshdajkfshdajklfhdsaljkfhsdaljkhfjdksahfljkadshfljkadshfjkdshfjklahjkfhadjkfhaslkfhladksfhlakdsjhflkjsdahfjkasdhfjklhdsfjkladshkfjhadskjfhasdkhfklajdshfkjladshfkjladshfjklhadskfjhadsfhdjksadsfdsafadsfjdasfdasjfkndasfnadsnfjkadshfjkahdsjkfhjalksdfhjkadfhjkladhfjkadshjkfadshjklfhadsjklfhjkldasfhjklasdhjfkhasjlkfhjsadkfhjklsdahfjklsdahljkfhsdjklafhjkldsahfjkldsahjkfsahdjkfhladjskhflkjasdhfjklsdahljkfhkjsdlfhkljsdhfkhdskljfhdskhfklsdhfkladhkfjahdsklfhadksjfhkdashfklsdahfkjshdajkfshdajklfhdsaljkfhsdaljkhfjdksahfljkadshfljkadshfjkdshfjklahjkfhadjkfhaslkfhladksfhlakdsjhflkjsdahfjkasdhfjklhdsfjkladshkfjhadskjfhasdkhfklajdshfkjladshfkjladshfjklhadskfjhadsfhdjksa"
    struct Log {
        var id : Int
        var body : String
        var bojNumber : String
        var category_id : Int
        var tag : String
        var date : String
        var Github_num : String
        var Github_title : String
        var Github_type : String
        var Github_date : String
        var Github_repo : String
        var image : String
        var bojTitle: String
        
        init(id : Int,body : String,bojNumber : String,category_id : Int,tag : String,date : String,Github_num : String,Github_title : String,Github_type : String,Github_date : String,Github_repo : String,image : String,bojTitle:String){
            
            self.id = id
            self.body = body
            self.bojNumber = bojNumber
            self.category_id = category_id
            self.tag = tag
            self.date = date
            self.Github_num = Github_num
            self.Github_title = Github_title
            self.Github_type = Github_type
            self.Github_date = Github_date
            self.Github_repo = Github_repo
            self.image = image
            self.bojTitle = bojTitle
        }
    }
    var D_data : Log = Log(id : 1,body :"dsfdsafadsfjdasfdasjfkndasfnadsnfjkadshfjkahdsjkfhjalksdfhjkadfhjkladhfjkadshjkfadshjklfhadsjklfhjkldasfhjklasdhjfkhasjlkfhjsadkfhjklsdahfjklsdahljkfhsdjklafhjkldsahfjkldsahjkfsahdjkfhladjskhflkjasdhfjklsdahljkfhkjsdlfhkljsdhfkhdskljfhdskhfklsdhfkladhkfjahdsklfhadksjfhkdashfklsdahfkjshdajkfshdajklfhdsaljkfhsdaljkhfjdksahfljkadshfljkadshfjkdshfjklahjkfhadjkfhaslkfhladksfhlakdsjhflkjsdahfjkasdhfjklhdsfjkladshkfjhadskjfhasdkhfklajdshfkjladshfkjladshfjklhadskfjhadsfhdjksadsfdsafadsfjdasfdasjfkndasfnadsnfjkadshfjkahdsjkfhjalksdfhjkadfhjkladhfjkadshjkfadshjklfhadsjklfhjkldasfhjklasdhjfkhasjlkfhjsadkfhjklsdahfjklsdahljkfhsdjklafhjkldsahfjkldsahjkfsahdjkfhladjskhflkjasdhfjklsdahljkfhkjsdlfhkljsdhfkhdskljfhdskhfklsdhfkladhkfjahdsklfhadksjfhkdashfklsdahfkjshdajkfshdajklfhdsaljkfhsdaljkhfjdksahfljkadshfljkadshfjkdshfjklahjkfhadjkfhaslkfhladksfhlakdsjhflkjsdahfjkasdhfjklhdsfjkladshkfjhadskjfhasdkhfklajdshfkjladshfkjladshfjklhadskfjhadsfhdjksadsfdsafadsfjdasfdasjfkndasfnadsnfjkadshfjkahdsjkfhjalksdfhjkadfhjkladhfjkadshjkfadshjklfhadsjklfhjkldasfhjklasdhjfkhasjlkfhjsadkfhjklsdahfjklsdahljkfhsdjklafhjkldsahfjkldsahjkfsahdjkfhladjskhflkjasdhfjklsdahljkfhkjsdlfhkljsdhfkhdskljfhdskhfklsdhfkladhkfjahdsklfhadksjfhkdashfklsdahfkjshdajkfshdajklfhdsaljkfhsdaljkhfjdksahfljkadshfljkadshfjkdshfjklahjkfhadjkfhaslkfhladksfhlakdsjhflkjsdahfjkasdhfjklhdsfjkladshkfjhadskjfhasdkhfklajdshfkjladshfkjladshfjklhadskfjhadsfhdjksadsfdsafadsfjdasfdasjfkndasfnadsnfjkadshfjkahdsjkfhjalksdfhjkadfhjkladhfjkadshjkfadshjklfhadsjklfhjkldasfhjklasdhjfkhasjlkfhjsadkfhjklsdahfjklsdahljkfhsdjklafhjkldsahfjkldsahjkfsahdjkfhladjskhflkjasdhfjklsdahljkfhkjsdlfhkljsdhfkhdskljfhdskhfklsdhfkladhkfjahdsklfhadksjfhkdashfklsdahfkjshdajkfshdajklfhdsaljkfhsdaljkhfjdksahfljkadshfljkadshfjkdshfjklahjkfhadjkfhaslkfhladksfhlakdsjhflkjsdahfjkasdhfjklhdsfjkladshkfjhadskjfhasdkhfklajdshfkjladshfkjladshfjklhadskfjhadsfhdjksadsfdsafadsfjdasfdasjfkndasfnadsnfjkadshfjkahdsjkfhjalksdfhjkadfhjkladhfjkadshjkfadshjklfhadsjklfhjkldasfhjklasdhjfkhasjlkfhjsadkfhjklsdahfjklsdahljkfhsdjklafhjkldsahfjkldsahjkfsahdjkfhladjskhflkjasdhfjklsdahljkfhkjsdlfhkljsdhfkhdskljfhdskhfklsdhfkladhkfjahdsklfhadksjfhkdashfklsdahfkjshdajkfshdajklfhdsaljkfhsdaljkhfjdksahfljkadshfljkadshfjkdshfjklahjkfhadjkfhaslkfhladksfhlakdsjhflkjsdahfjkasdhfjklhdsfjkladshkfjhadskjfhasdkhfklajdshfkjladshfkjladshfjklhadskfjhadsfhdjksadsfdsafadsfjdasfdasjfkndasfnadsnfjkadshfjkahdsjkfhjalksdfhjkadfhjkladhfjkadshjkfadshjklfhadsjklfhjkldasfhjklasdhjfkhasjlkfhjsadkfhjklsdahfjklsdahljkfhsdjklafhjkldsahfjkldsahjkfsahdjkfhladjskhflkjasdhfjklsdahljkfhkjsdlfhkljsdhfkhdskljfhdskhfklsdhfkladhkfjahdsklfhadksjfhkdashfklsdahfkjshdajkfshdajklfhdsaljkfhsdaljkhfjdksahfljkadshfljkadshfjkdshfjklahjkfhadjkfhaslkfhladksfhlakdsjhflkjsdahfjkasdhfjklhdsfjkladshkfjhadskjfhasdkhfklajdshfkjladshfkjladshfjklhadskfjhadsfhdjksa",bojNumber : "4949",category_id : 1,tag : "Python;백준;",date : "2020-11-18",Github_num : "648632ad",Github_title : "commit함",Github_type : "pull request",Github_date : "2020/3/13",Github_repo : "repo contents",image : "/",bojTitle : "균형잡힌 세상")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        DataLoad()
        Make_contents()
        D_body.delegate = self
        D_body.delegate?.textViewDidChange?(D_body)
        D_body.isScrollEnabled = false
        // Do any additional setup after loading the view.
        scrollview.contentSize = CGSize(width: scrollview.frame.width, height: 20000)
        navigationController?.hidesBarsOnSwipe = true
        //백준 누르면 웹뷰이동
        let tapGesture_bj = UITapGestureRecognizer(target: self, action: #selector(goBjLink(sender:)))
        D_contents.addGestureRecognizer(tapGesture_bj)
        //git 누르면 웹뷰아동
        let tapGesture_git = UITapGestureRecognizer(target: self, action: #selector(goGitLink(sender:)))
        git_contents.addGestureRecognizer(tapGesture_git)
        //수정 삭제버튼 생성
        let interaction = UIContextMenuInteraction(delegate: self)
        ed_button.addInteraction(interaction)
        D_img.image=UIImage(named: "exampleimage")
        D_contents.isHidden=true
        git_contents.isHidden=false
//        textViewAutoLayout()
    }
   
    
    //데이터 로드 및 세팅 함수
    func DataLoad (){
        D_title.text = "\(category_name)의 \(log_cate_id)번째 기록"
        D_tag.text = D_data.tag
        D_date.text=D_data.date
    }
    //view custom
    
    
    func Make_contents(){
        if (category_name != ""){
            D_contents.layer.borderWidth = 0.3
            D_contents.layer.borderColor = UIColor.lightGray.cgColor
            D_contents.layer.cornerRadius=40
            D_contents.layer.shadowColor = UIColor.gray.cgColor
            D_contents.layer.shadowRadius = 8
            D_contents.layer.shadowOffset = CGSize(width: 0, height: 4)
            D_contents.layer.shadowOpacity = 0.3
            contents_label.text = "\(D_data.bojNumber)번  -  \(D_data.bojTitle) "
            
            boj_link = "https://www.acmicpc.net/problem/\(D_data.bojNumber)"
        }
        if (Github_num != ""){git_contents.layer.borderWidth = 0.3
            git_contents.layer.borderColor = UIColor.lightGray.cgColor
            git_contents.layer.cornerRadius=40
            git_contents.layer.shadowColor = UIColor.gray.cgColor
            git_contents.layer.shadowRadius = 8
            git_contents.layer.shadowOffset = CGSize(width: 0, height: 4)
            git_contents.layer.shadowOpacity = 0.3
            git_label.text = "\(D_data.Github_title)"
            git_repo.text = "\(D_data.Github_repo)"
            git_type.text = "\(D_data.Github_type)"
            git_Date.text = "\(D_data.Github_date)"
            git_link = "https://www.acmicpc.net/problem/\(D_data.bojNumber)"
            git_type_view.layer.borderWidth = 0.3
            if (D_data.Github_type=="commit"){
                git_type_view.layer.borderColor = UIColor.green.cgColor
                git_link = "https://github.com\(gitRepoName)/commits"
            }else if(D_data.Github_type=="issue"){
                git_type_view.layer.borderColor = UIColor.red.cgColor
                git_link = "https://github.com\(gitRepoName)/issues"

            }else if(D_data.Github_type=="pull request"){
                git_type_view.layer.borderColor = UIColor.blue.cgColor
                git_link = "https://github.com\(gitRepoName)/pulls"
            }
            git_type_view.layer.cornerRadius=10
        }
       
        
    }
    //백준 터치시 링크로 이동
    @objc func goBjLink(sender:UIGestureRecognizer){
        let contentsUrl = NSURL(string: boj_link)
        let LinkSafariView: SFSafariViewController = SFSafariViewController(url: contentsUrl as! URL)
        self.present(LinkSafariView, animated: true, completion: nil)
    }
    //github 터치시 링크로 이동
    @objc func goGitLink(sender:UIGestureRecognizer){
        let contentsUrl = NSURL(string: git_link)
        let LinkSafariView: SFSafariViewController = SFSafariViewController(url: contentsUrl as! URL)
        self.present(LinkSafariView, animated: true, completion: nil)
    }
    //스크롤뷰
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard velocity.y != 0 else { return }
            if velocity.y < 0 {
                let height = self?.tabBarController?.tabBar.frame.height ?? 0.0
                self?.tabBarController?.tabBar.alpha = 1.0
                self?.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY - height)
            } else {
                self?.tabBarController?.tabBar.alpha = 0.0
                self?.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY)
            }
        }
    }
    //textView 동적 레이아웃
    func textViewAutoLayout(){
//        D_body.translatesAutoresizingMaskIntoConstraints = false
        D_contents.translatesAutoresizingMaskIntoConstraints = true
        //백준, git 둘다 없을 때
//        D_body.topAnchor.constraint(equalTo:D_title.bottomAnchor, constant: 40.0).isActive = true
        //백준, git 하나만 없을 때
//        D_contents.topAnchor.constraint(equalTo:D_title.bottomAnchor, constant: 30.0).isActive = true
//        D_body.topAnchor.constraint(equalTo:D_contents.bottomAnchor, constant: 140.0).isActive = true
    }
 

    
    
    //디테일 뷰 모달창 닫는 함수
    @IBAction func close_log(_ sender: Any) {
        self.dismiss(animated: true)
    }
    //수정 및 삭제 버튼
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension DetailViewController : UITextViewDelegate{
    //동적으로 textview 크기 늘리기
    func textViewDidChange(_ D_body: UITextView) {
        D_body.text=D_data.body
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = D_body.sizeThatFits(size)
        D_body.constraints.forEach{(constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
