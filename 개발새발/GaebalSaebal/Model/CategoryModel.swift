//
//  CategoryModel.swift
//  GaebalSaebal
//
//  Created by 이봄이 on 2022/05/14.
//

import UIKit

struct MyCategory {
    let contentHeightSize: CGFloat
    let commentString: String
    let contentString: [String]
    let color : UIColor
    
    static func getMock() -> [Self] {
        
        var datas: [MyCategory] = []
        var tempHeight: CGFloat
        
        for i in 0...categoryArray.count - 1 {
            switch contentsArray[i].count {
            case 0:
                tempHeight = CGFloat(110)
            case 1:
                tempHeight = CGFloat(140)
            case 2:
                tempHeight = CGFloat(170)
            case 3:
                tempHeight = CGFloat(200)
            case 4:
                tempHeight = CGFloat(230)
            case 5:
                tempHeight = CGFloat(260)
            default:
                tempHeight = CGFloat(260)
            }
            let imageHeightSize = tempHeight
            
            let red = CGFloat(arc4random_uniform(47) + 130)
            let green = CGFloat(arc4random_uniform(47) + 130)
            
            let color = UIColor.init(red: red / 255, green: green / 255, blue: 255/255, alpha: 1.0)
            
            let myCategory: MyCategory = .init(contentHeightSize: imageHeightSize, commentString: categoryArray[i], contentString: contentsArray[i], color: color)
            datas += [myCategory]
        }
        return datas
        
    }
}


let categoryArray = ["가나다라마바사아자차", "자유기록", "개발새발", "자료구조", "백준", "기본보관함", "자유기록", "개발새발", "자료구조", "백준", "dadahae"]
var contentsArray = [["어쩌구"], ["python 기초문법", "pull request"], ["C언어로 Stack 구현하기,, C언어로 Stack 구현하기 C언어로 Stack 구현하기,, C언어로 Stack 구현하기", "Python으로 Stack 구현하기", "C: 노드"], ["하단바 구현","홈 view UI 구현", "깃허브 API 연동", "기록 작성 뷰 구현"], [], ["어쩌구"], ["python 기초문법", "pull request"], ["C언어로 Stack 구현하기", "Python으로 Stack 구현하기", "C: 노드"], ["하단바 구현","홈 view UI 구현", "깃허브 API 연동", "기록 작성 뷰 구현"], [],["키체인", "swift", "URLSession", "Vision", "hello", "CoreData"]]
