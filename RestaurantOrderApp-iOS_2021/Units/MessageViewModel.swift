//
//  MessageViewModel.swift
//  RestaurantOrderApp-iOS_2021
//
//  Created by Jonas Bergström on 2021-02-25.
//
import Foundation
import Firebase

struct Message: Codable, Identifiable {
    var id: String?
    var content: String
    var name: String
    
}

class MessageViewModel: ObservableObject {
    
    @Published var messages = [Message]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    
    func sendMessage(messageContent: String, docId: String) {
        if (user != nil){
            db.collection("Chatrooms").document(docId).collection("messages").addDocument(data: [
                "sentAt": Date(),
                "content": messageContent,
                "sender": user!.uid])
        }
    }
    
    func fetchData(docId: String) {
        
        if (user != nil) {
            db.collection("Chatrooms").document(docId).collection("messages").order(by: "sentAt", descending: true) .addSnapshotListener({
                (snapshot, error)
                in
                guard let documents = snapshot?.documents else {
                    print ("no docs")
                    return
                }
                
                self.messages = documents.map{
                    docSnapshot -> Message in
                    let data = docSnapshot.data()
                    let docId = docSnapshot.documentID
                    let content = data["content"] as? String ?? ""
                    return Message(id: docId, content: content, name: "Kund")
                }
            })
        }
        
        
        
    }
        
        
        
  
}

