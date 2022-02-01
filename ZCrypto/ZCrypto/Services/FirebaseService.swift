//
//  FirebaseService.swift
//  ZCrypto
//
//  Created by Ishaan Bhasin on 11/27/21.
//

import Foundation
import Firebase
import FirebaseDatabase

class FirebaseService{
    static let instance = FirebaseService()
    let auth: Auth
    let ref: DatabaseReference
    
    private init(){
        auth = Auth.auth()
        ref = Database.database().reference()
    }
}
