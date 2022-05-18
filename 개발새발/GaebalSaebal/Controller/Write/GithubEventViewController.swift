//
//  GithubRepoViewController.swift
//  GaebalSaebal
//
//  Created by DOYEONLEE2 on 2022/05/16.
//

import UIKit

class GithubEventViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.backgroundColor = UIColor.clear
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        print("ViewController의 view가 사라짐")
    }
    

}

extension GithubEventViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    //섹션 간격
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "githubRepoCell", for: indexPath)
        
        return cell
    }
    
    // 터치 이벤트
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)

    }

    
}
