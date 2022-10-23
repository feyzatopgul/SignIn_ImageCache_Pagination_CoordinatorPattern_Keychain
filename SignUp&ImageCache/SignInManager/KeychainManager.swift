//
//  KeychainManager.swift
//  SignUp&ImageCache
//
//  Created by fyz on 8/22/22.
//

import CoreFoundation
import Security
import Foundation
/*
 Keychain has 2 main parts: SecKeyChain: encrypted database, SecKeychainItem: items inserted to the db
 5 types of item classes:
 kSecClassGenericPassword: for generic passwords
 kSecClassInternetPassword: for internet passwords
 kSecClassCertificate: for certificates
 kSecClassKey: for cryptographic keys
 kSecClassIdentity: for identities
*/

class KeychainManager {
    
    static let standard = KeychainManager()
    private init(){}
    
    enum KeychainError: Error{
        case duplicateEntry
        case unknown(OSStatus)
    }
    
    func save(service: String, account: String, password: Data) throws {
        let query:[String: AnyObject] = [
            kSecValueData as String: password as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicateEntry
        }
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
    }
    
    func get(service: String, account: String) -> Data? {
        let query:[String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)
        return result as? Data
    }
    
    func delete(service: String, account: String) {
        let query:[String:AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject
        ]
        SecItemDelete(query as CFDictionary)
    }
}
