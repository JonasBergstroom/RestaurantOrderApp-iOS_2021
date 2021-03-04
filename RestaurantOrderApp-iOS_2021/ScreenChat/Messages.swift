//
//  Messages.swift
//  RestaurantOrderApp-iOS_2021
//
//  Created by Jonas Bergström on 2021-02-25.
//

import SwiftUI

struct Messages: View {
    
    let chatroom: Chatroomss
    @ObservedObject var viewModel = MessageViewModel()
    @State var messageField = ""
    @Environment(\.presentationMode) var presentationMode
    
    
    init(chatroom: Chatroomss) {
        self.chatroom = chatroom
        viewModel.fetchData(docId: chatroom.id)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.messages) {
                    message in
                    HStack {
                        Text(message.content)
                        Spacer()
                    }
                }
                
                HStack {
                    TextField("Enter messages...", text: $messageField)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        viewModel.sendMessage(messageContent: messageField, docId: chatroom.id)
                        messageField = ""
                    },
                    label: {
                        Text("Send")
                    })
                }
            }
            .navigationBarTitle("Chat")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Back")

                    })
                }
               
            })
        }
    }
}




