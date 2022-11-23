//
//  GitadminViewController.swift
//  GaebalSaebal
//
//  Created by 김가은 on 2022/05/09.
//

import UIKit

class GitadminViewController: UIViewController {

    var Token = ""
    var flag = true
    @IBOutlet weak var TokenInp: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "깃허브 사용자 설정"
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if (flag) {
            TokenInp.placeholder = "Token 값이 저장 되지 않았습니다."
        }else{
            TokenInp.placeholder = "Token 값이 저장 되었습니다."
        }
        Token = TokenInp.text ?? ""
    }
    
    @IBAction func SaveInfo(_ sender: Any) {
        Token = TokenInp.text ?? ""
        let alert = UIAlertController(title: "저장완료", message: "저장되었습니다.", preferredStyle: .alert)

        let ok = UIAlertAction(title: "OK", style: .default) { (ok) in
                        UserDefaults.standard.setValue(self.TokenInp.text, forKey: "token")
                        self.TokenInp.placeholder = "Token 값이 저장 되었습니다."
                        self.flag = false
                    }

                    alert.addAction(ok)

                    self.present(alert, animated: true, completion: nil)
    }

}
