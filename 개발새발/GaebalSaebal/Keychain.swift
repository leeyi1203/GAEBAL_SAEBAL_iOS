//
//  Keychain.swift
//  GaebalSaebal
//
//  Created by 김가은 on 2022/11/23.
//

import Foundation
//키체인에 추가하는 예제 코드
class KeyChain {
    enum KeychainError : Error{
        case duplicateEntry
        case unknown(OSStatus)
    }
    static func save(
        service : String,
        account : String,
        password : Data
    ) throws {
        let query : [String : AnyObject] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrService as String : service as AnyObject,
            kSecAttrAccount as String : account as AnyObject,
            kSecValueData as String : password as AnyObject
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicateEntry
        }
        guard status == errSecSuccess else{
            throw KeychainError.unknown(status)
        }
        print("saved")
    }
    
    static func get(
        service : String,
        account : String
    )  ->Data? {
        let query : [String : AnyObject] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrService as String : service as AnyObject, 
            kSecAttrAccount as String : account as AnyObject,
            kSecReturnData as String : kCFBooleanTrue,
            kSecMatchLimit as String : kSecMatchLimitOne
        ]
        var result : AnyObject?
        
        
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
     
        print("Read status : \(status)")
        return result as? Data
    }
    static func updateKey(value: Any, service:Any,account: Any) -> Bool {
        let prevQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,kSecAttrService : service,
                                                  kSecAttrAccount: account]
            let updateQuery: [CFString: Any] = [kSecValueData: (value as AnyObject).data(using: String.Encoding.utf8.rawValue) as Any]

            let result: Bool = {
                let status = SecItemUpdate(prevQuery as CFDictionary, updateQuery as CFDictionary)
                if status == errSecSuccess { return true }

                print("updateItem Error : \(status.description)")
                return false
            }()

            return result
        }
    
//        static let shared = KeyChain()
//
//        func addItem(id: Any, pwd: Any) -> Bool {
//            let addQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
//                                             kSecAttrAccount: id,
//                                             kSecValueData: (pwd as AnyObject).data(using: String.Encoding.utf8.rawValue) as Any]
//
//            let result: Bool = {
//                let status = SecItemAdd(addQuery as CFDictionary, nil)
//                if status == errSecSuccess {
//                    return true
//                } else if status == errSecDuplicateItem {
//                    return updateItem(value: pwd, key: id)
//                }
//
//                print("addItem Error : \(status.description))")
//                return false
//            }()
//
//            return result
//        }
//
//        func getItem(key: Any) -> Any? {
//            let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
//                                          kSecAttrAccount: key,
//                                          kSecReturnAttributes: true,
//                                          kSecReturnData: true]
//            var item: CFTypeRef?
//            let result = SecItemCopyMatching(query as CFDictionary, &item)
//
//            if result == errSecSuccess {
//                if let existingItem = item as? [String: Any],
//                   let data = existingItem[kSecValueData as String] as? Data,
//                   let password = String(data: data, encoding: .utf8) {
//                    return password
//                }
//            }
//
//            print("getItem Error : \(result.description)")
//            return nil
//        }
//

////
//        func deleteItem(key: String) -> Bool {
//            let deleteQuery : [String : AnyObject] = [
//                kSecClass as String : kSecClassGenericPassword,
//                kSecAttrService as String : service as AnyObject,
//                kSecAttrAccount as String : account as AnyObject,
//                kSecValueData as String : password as AnyObject
//            ]
////            let deleteQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
////                                                kSecAttrAccount: key]
//            let status = SecItemDelete(deleteQuery as CFDictionary)
//            if status == errSecSuccess { return true }
//
//            print("deleteItem Error : \(status.description)")
//            return false
//        }
    }
