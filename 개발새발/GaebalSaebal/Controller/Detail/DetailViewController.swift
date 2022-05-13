//
//  DetailViewController.swift
//  GaebalSaebal
//
//  Created by 김가은 on 2022/04/30.
//

import UIKit
import SafariServices
import SwiftUI
class DetailViewController: UIViewController, UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (_: [UIMenuElement]) -> UIMenu? in
                    
                    let btn1 = UIAction(title: "수정", image: UIImage(systemName: "")) { (UIAction) in
                        print("수정 클릭됨")
                    }
                    let btn2 = UIAction(title: "삭제", image: UIImage(systemName: "")) { (UIAction) in
                        print("삭제 클릭됨")
                    }
                    
                    return UIMenu(children: [btn1,btn2])
                }
    }
    // MARK: - Declaration
    
    @IBOutlet weak var D_title: UILabel!
    @IBOutlet weak var D_contents: UIView!
    @IBOutlet weak var D_body: UITextView!
    @IBOutlet weak var D_tag: UILabel!
    @IBOutlet weak var D_date: UILabel!
    @IBOutlet weak var contexMenu: UIView!
    @IBOutlet weak var contents_label: UILabel!
    @IBOutlet weak var ed_button: UIButton!
    //temporary data
    var category_name = "백준"
    var log_cate_id = 2
    var boj_link = ""
    let body_ex = "dsfdsafadsfjdasfdasjfkndasfnadsnfjkadshfjkahdsjkfhjalksdfhjkadfhjkladhfjkadshjkfadshjklfhadsjklfhjkldasfhjklasdhjfkhasjlkfhjsadkfhjklsdahfjklsdahljkfhsdjklafhjkldsahfjkldsahjkfsahdjkfhladjskhflkjasdhfjklsdahljkfhkjsdlfhkljsdhfkhdskljfhdskhfklsdhfkladhkfjahdsklfhadksjfhkdashfklsdahfkjshdajkfshdajklfhdsaljkfhsdaljkhfjdksahfljkadshfljkadshfjkdshfjklahjkfhadjkfhaslkfhladksfhlakdsjhflkjsdahfjkasdhfjklhdsfjkladshkfjhadskjfhasdkhfklajdshfkjladshfkjladshfjklhadskfjhadsfhdjksa"
    struct Log {
        var id : Int
        var body : String
        var BOJ_num : String
        var category_id : Int
        var tag : String
        var date : String
        var Github_num : String
        var Github_title : String
        var Github_type : String
        var Github_date : String
        var Github_repo : String
        var image : String
        
        init(id : Int,body : String,BOJ_num : String,category_id : Int,tag : String,date : String,Github_num : String,Github_title : String,Github_type : String,Github_date : String,Github_repo : String,image : String){
            self.id = id
            self.body = body
            self.BOJ_num = BOJ_num
            self.category_id = category_id
            self.tag = tag
            self.date = date
            self.Github_num = Github_num
            self.Github_title = Github_title
            self.Github_type = Github_type
            self.Github_date = Github_date
            self.Github_repo = Github_repo
            self.image = image
        }
    }
    var D_data : Log = Log(id : 1,body : "dsfdsafadsfjdasfdasjfkndasfnadsnfjkadshfjkahdsjkfhjalksdfhjkadfhjkladhfjkadshjkfadshjklfhadsjklfhjkldasfhjklasdhjfkhasjlkfhjsadkfhjklsdahfjklsdahljkfhsdjklafhjkldsahfjkldsahjkfsahdjkfhladjskhflkjasdhfjklsdahljkfhkjsdlfhkljsdhfkhdskljfhdskhfklsdhfkladhkfjahdsklfhadksjfhkdashfklsdahfkjshdajkfshdajklfhdsaljkfhsdaljkhfjdksahfljkadshfljkadshfjkdshfjklahjkfhadjkfhaslkfhladksfhlakdsjhflkjsdahfjkasdhfjklhdsfjkladshkfjhadskjfhasdkhfklajdshfkjladshfkjladshfjklhadskfjhadsfhdjksa" ,BOJ_num : "4949",category_id : 1,tag : "Python;백준;",date : "2020-11-18",Github_num : "648632ad",Github_title : "commit함",Github_type : "commit",Github_date : "2020/3/13",Github_repo : "repo contents",image : "/")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        DataLoad()
        Make_contents()
        D_body.delegate = self
        D_body.delegate?.textViewDidChange?(D_body)
        D_body.isScrollEnabled = false
        // Do any additional setup after loading the view.
        
        //클릭이벤트
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goLink(sender:)))
        D_contents.addGestureRecognizer(tapGesture)
        
        let interaction = UIContextMenuInteraction(delegate: self)
        ed_button.addInteraction(interaction)
        
        
    }
    
    //데이터 로드 및 세팅 함수
    func DataLoad (){
        D_title.text = "\(category_name)의 \(log_cate_id)번째 기록"
        D_tag.text = D_data.tag
        D_date.text=D_data.date
        print("#DataLoad")
        
    }
    //view custom
    func Make_contents(){
        D_contents.layer.borderWidth = 0.3
        D_contents.layer.borderColor = UIColor.lightGray.cgColor
        D_contents.layer.cornerRadius=40
        D_contents.layer.shadowColor = UIColor.gray.cgColor
        D_contents.layer.shadowRadius = 8
        D_contents.layer.shadowOffset = CGSize(width: 0, height: 4)
        D_contents.layer.shadowOpacity = 0.3
        contents_label.text = "\(D_data.BOJ_num)번  -   "
        boj_link = "https://www.acmicpc.net/problem/\(D_data.BOJ_num)"
    }
    //D_contents 터치시 링크로 이동
    @objc func goLink(sender:UIGestureRecognizer){
        let contentsUrl = NSURL(string: boj_link)
        let LinkSafariView: SFSafariViewController = SFSafariViewController(url: contentsUrl as! URL)
        self.present(LinkSafariView, animated: true, completion: nil)
    }
 

    
    
    //모달창 닫는 함수
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
    func textViewDidChange(_ D_body: UITextView) {
        print("#deletate")
        D_body.text=D_data.body
        print(D_body.text)
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = D_body.sizeThatFits(size)
        D_body.constraints.forEach{(constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
