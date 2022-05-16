//
//  GithubReposViewController.swift
//  GaebalSaebal
//
//  Created by DOYEONLEE2 on 2022/05/17.
//

import UIKit

var repoNames:[String] = []

class GithubReposViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // 유저의 레포들 가져오기
        getUserRepos()
        
    }

}

extension GithubReposViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return repoNames.count
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
        
        if let cell = cell as? GithubRepoTableViewCell {
            cell.repoNameLabel.text = repoNames[indexPath.section]
        }
        
        return cell
    }
    

    
}

extension GithubReposViewController{
    
    public struct UserRepoInfo: Codable {
        public let name:String
    }

    func getUserRepos(){
//        let userName:String = "leedoyeon849"
//        let url = "https://api.github.com/users/\(userName)/repos"
//        NetworkHandler.getData(resource: url)
//        print("getUserRepos 실행됨")

        let auth = "Token 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"

//        let url:URL = URL(string: "https://api.github.com/users/\(userName)/repos")!
        let url:URL = URL(string: "https://api.github.com/user/repos")!
        var urlReq:URLRequest = URLRequest.init(url: url)
        urlReq.addValue(auth, forHTTPHeaderField: "Authorization")
        urlReq.httpMethod = "GET"
        urlReq.allHTTPHeaderFields = ["Content-Type":"application/json"]
        let IPTask = URLSession.shared.dataTask(with: urlReq) { (data, res, err) in
            if let data = data {

                let jsonData = try? JSONDecoder().decode([UserRepoInfo].self, from: data)
                guard let rsData = jsonData else {
                    return
                }
                print("##\(rsData[0])")
                for rsItem in rsData {
                    repoNames.append(rsItem.name)

                }
            }
            print(repoNames)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        IPTask.resume()


    }
}

