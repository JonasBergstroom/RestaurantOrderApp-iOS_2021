//
//  ChatroomsViewModel.swift
//  RestaurantOrderApp-iOS_2021
//
//  Created by Jonas Bergström on 2021-02-25.
//

import Foundation
import Firebase

struct Chatroomss: Codable, Identifiable {
    var id: String
}


class ChatroomsViewModel: ObservableObject {
    
    @Published var chatrooms = [Chatroomss]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    func fetchData() {
        
        if (user != nil) {
            db.collection("Chatrooms").whereField("userss", arrayContains: user!.uid).addSnapshotListener({
                (snapshot, error)
                in
                guard let documents = snapshot?.documents else {
                    print ("no docs returned!")
                    return
                }
                
                self.chatrooms = documents.map({
                    docSnapshot -> Chatroomss in
                    let data = docSnapshot.data()
                    let docId = docSnapshot.documentID
                    return Chatroomss(id: docId)
                })
            })
        }
        
        
        
        
    }
    
    func createChatroom( handler: @escaping () -> Void) {
        
        if (user != nil) {
            if let uid = user?.uid {
                
                db.collection("Chatrooms").document(uid).setData(["user":uid]) {
                    err in
                    if let err = err {
                        print("error adding \(err)")
                    }else {
                        handler()
                    }
                }
                
                
            }
            
        }
        
        
        
        
        
        
    }
    
    
    
    
    
}




