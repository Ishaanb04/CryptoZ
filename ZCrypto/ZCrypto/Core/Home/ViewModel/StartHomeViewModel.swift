//
//  StartHomeViewModel.swift
//  ZCrypto
//
//  Created by Ishaan Bhasin on 11/27/21.
//

import Foundation
import FirebaseDatabase

class StartHomeViewModel: ObservableObject{
    @Published var coinEntries: [String: Coin] = [:]
    @Published var showError: Bool = false
    let firebaseService: FirebaseService = FirebaseService.instance
    var errorMessage: String = ""
    var currentUserId: String?
    let rootReference: DatabaseReference = Database.database().reference()
    @Published var signedIn: Bool = false
    
    init(){
        self.getAllData()
        self.coinObservation()
    }
    
    var isSignedIn: Bool{
        firebaseService.auth.currentUser != nil
    }
    
    func signIn(email: String, password: String){
        firebaseService.auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error{
                DispatchQueue.main.async {
                    self?.showError = true
                    self?.errorMessage = "Error: \(error.localizedDescription)"
                }
            }
            DispatchQueue.main.async {
                self?.currentUserId = self?.firebaseService.auth.currentUser?.uid
                self?.signedIn = self?.firebaseService.auth.currentUser != nil
            }
        }
    }
    
    func getAllData(){
        if let currentUserId = currentUserId {
            rootReference.child(currentUserId).getData { error, snapshot in
                if let error = error {
                    print("Error getting Data: \(error.localizedDescription)")
                }
                DispatchQueue.main.async {
                    for childNode in snapshot.children{
                        if let item = childNode as? DataSnapshot{
                            if let value = item.value as? NSDictionary,
                               let coin = Coin.coinModelFromDict(value)
                            {self.coinEntries[coin.id] = coin}
                        }
                    }
                }
            }
        }
    }
    
    func addCoinEntry(entry: inout Coin){
        let childRef = rootReference.child("video").childByAutoId()
        childRef.setValue(entry.dictionary)
    }
    
    func coinObservation(){
        if let currentUserId = currentUserId{
            rootReference.child(currentUserId).observe(.childAdded) { snapshot in
                if let value = snapshot.value as? NSDictionary,
                   let coin = Coin.coinModelFromDict(value)
                {self.coinEntries[coin.id] = coin}
            }
            rootReference.child(currentUserId).observe(.childRemoved) { snapshot in
                self.coinEntries.removeValue(forKey: snapshot.key)
            }
            rootReference.child(currentUserId).observe(.childChanged) { snapshot in
                if let value = snapshot.value as? NSDictionary,
                   let coin = Coin.coinModelFromDict(value)
                {self.coinEntries[coin.id] = coin}
            }
        }
    }
    
    func signout(){
        do{
            try firebaseService.auth.signOut()
        }catch let error{
            print("\(error.localizedDescription)")
        }
    }
    
    func signUp(email: String, password: String){
        firebaseService.auth.createUser(withEmail: email, password: password){ [weak self] result, error in
            if let error = error{
                DispatchQueue.main.async {
                    self?.showError = true
                    self?.errorMessage = "Error: \(error.localizedDescription)"
                }
            }
        
        }
    }
}
