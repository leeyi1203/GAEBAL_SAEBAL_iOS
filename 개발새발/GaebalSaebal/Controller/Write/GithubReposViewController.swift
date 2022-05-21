//
//  GithubReposViewController.swift
//  GaebalSaebal
//
//  Created by DOYEONLEE2 on 2022/05/17.
//

import UIKit



class GithubReposViewController: UIViewController {
    
    var repoFullNames: [String] = []
    var repoNames: [String] = []
    var repo: String = ""
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        self.repoNames.removeAll()
        self.tableView.reloadData()
        
        // 유저의 레포들 가져오기
        getUserRepos()
        
    }

}

// MARK: - ✅ Table View
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
            cell.repoNameLabel.text = repoFullNames[indexPath.section]
        }
        
        return cell
    }
    
    // 터치 이벤트
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        
        self.repo = self.repoNames[indexPath.section]

        
        // 이벤트 선택 페이지로 이동
        self.performSegue(withIdentifier: "showGithubEventListView", sender: nil)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if (segue.identifier == "showGithubEventListView") {
          let secondView = segue.destination as! GithubEventViewController
           secondView.repo = self.repo
       }
    }

}

// MARK: - ✅ GitHub Rest API - Get user repos
extension GithubReposViewController{
    
    public struct owner: Codable{
        public let login:String
    }
    
    public struct UserRepoInfo: Codable {
        public let full_name:String
        public let name:String
        public let owner:owner
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
                    self.repoFullNames.append(rsItem.full_name)
                    self.repoNames.append(rsItem.name)

                }
            }
            print(self.repoNames)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        IPTask.resume()


    }
}

// MARK: - ✅ Custom segue
//  CustomSegueClass.swift
import UIKit
 
  // RightViewController  뷰 이동
  class right: UIStoryboardSegue {
      override func perform()
      {
          let src = self.source as UIViewController
          let dst = self.destination as UIViewController
          src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
          dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
          UIView.animate(withDuration: 0.25,
                                     delay: 0.0,
                                    options: UIView.AnimationOptions.curveEaseInOut,
                                     animations: {
                                      dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
                                      src.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width/1, y: 0)
          },
                                     completion: { finished in
                                      src.present(dst, animated: false, completion: nil)
          }
          )
      }
  }
 
  // RightViewController  뷰 닫기
  class Unwind_right: UIStoryboardSegue {
      override func perform()
      {
          let src = self.source as UIViewController
          let dst = self.destination as UIViewController
          src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
          src.view.transform = CGAffineTransform(translationX: 0, y: 0)
          dst.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width/3, y: 0)
          UIView.animate(withDuration: 0.25,
                                     delay: 0.0,
                                    options: UIView.AnimationOptions.curveEaseInOut,
                                     animations: {
                                      src.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
                                      dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
          },
                                     completion: { finished in
                                      src.dismiss(animated: false, completion: nil)
          }
          )
      }
  }

