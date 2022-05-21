//
//  ViewController.swift
//  GaebalSaebal
//
//  Created by 이봄이 on 2022/04/06.
//

import UIKit

class ViewController: UIViewController {
    public struct UserInfo: Codable {
        public let state: String
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        restapii()
    }
    func restapii(){
        print("실행됨")
        let url:URL = URL(string: "https://api.github.com/repos/ProjectInTheClass/GasaOK/issues")!
        var urlReq:URLRequest = URLRequest.init(url: url)
        urlReq.httpMethod = "GET"
        urlReq.allHTTPHeaderFields = ["Content-Type":"application/json"]
        let IPTask = URLSession.shared.dataTask(with: urlReq) { (data, res, err) in
            if let data = data {
                let jsonData = try? JSONDecoder().decode([UserInfo].self, from: data)
                guard let rsData = jsonData else {
                    return
                }
                print("##\(rsData[0].state)")
            }
        }
        IPTask.resume()
    }
}

