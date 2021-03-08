//
//  MessageViewModel.swift
//  RestaurantOrderApp-iOS_2021
//
//  Created by Jonas Bergström on 2021-02-25.
//
import Foundation
import Firebase

struct Message: Codable, Identifiable {
    
    // Content of each individual message
    
    var id: String?
    var content: String
    var name: String
    
}

class MessageViewModel: ObservableObject {
    
    // Holding the messages objects returned by firebase
    
    @Published var messages = [Message]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    
    func sendMessage(messageContent: String, docId: String) {
        
        // Will set information of the current sender to the firebase
        
        if (user != nil){
            db.collection("Chatrooms").document(docId).collection("messages").addDocument(data: [
                "sentAt": Date(),
                "content": messageContent,
                "sender": user!.uid])
        }
    }
    
    func fetchData(docId: String) {
        
        // Makes the messages store at the same sender to the firebase collection whenever a messages is sent
        
        if (user != nil) {
            db.collection("Chatrooms").document(docId).collection("messages").order(by: "sentAt", descending: true) .addSnapshotListener({
                (snapshot, error)
                in
                guard let documents = snapshot?.documents else {
                    print ("no docs")
                    return
                }
                
                self.messages = documents.map{
                    
                    // Uppdating every time a user sends at message
                    
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

