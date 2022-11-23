//
//  Struct.swift
//  GaebalSaebal
//
//  Created by 김가은 on 2022/11/23.
//

import Foundation
struct apiResult : Codable {
    let result : String
}
func updateKey(updatekey: String) -> Bool{
    var result = false
    result = KeyChain.updateKey(value: updatekey, service: "ser1", account: "userToken")
//    guard let result = KeyChain.updateKey(value: updatekey, service: "ser1", account: "userToken") else{
//        print("Failed to update key")
//        return false
//    }
    return result
}
func getKey(account: String) -> String{
    guard let data = KeyChain.get(service: "ser1", account: account) else{
        print("Failed to read key")
        return ""
    }
    let key = String(decoding: data, as: UTF8.self)
    print("Read Key : \(key)")
    return key
}

func save(account : String,pw : String){
    do{
        try KeyChain.save(service: "ser1", account: account, password: pw.data(using: .utf8) ?? Data())
    }catch{
        print(error)
    }
}
