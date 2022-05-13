//
//  GitadminViewController.swift
//  GaebalSaebal
//
//  Created by 김가은 on 2022/05/09.
//

import UIKit

class GitadminViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let testButton = UIButton()
                testButton.setTitle("클릭해주세요!", for: .normal)
                testButton.backgroundColor = .purple
                testButton.translatesAutoresizingMaskIntoConstraints = false
                
                view.addSubview(testButton)
        // Do any additional setup after loading the view.
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
