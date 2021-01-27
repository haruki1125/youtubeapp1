//
//  SendDB.swift
//  YoutubeApp1
//
//  Created by 大内晴貴 on 2021/01/25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

protocol DoneSendProfileDelegate {
    

    func doneSendProfileDelegate(sendCheck:Int)
    
}

class SendDB {
    
    var userName = String()
    var imageDate = Data()
    var db = Firestore.firestore()
    var doneSendProfileDelegate:DoneSendProfileDelegate?
    
    var userID = String()
    var urlString = String()
    var videoID = String()
    var title = String()
    var publishTime = String()
    var description = String()
    var channelTitle = String()
    
    
    
    init() {
        
    }
    
    init(userID:String,userName:String,urlString:String,videoID:String,title:String,publishTime:String,description:String,channelTitle:String) {
        
        self.userID = userID
        self.userName = userName
        self.urlString = urlString
        self.videoID = videoID
        self.title = title
        self.publishTime = publishTime
        self.channelTitle = channelTitle
        
        
    }
    
    
    func sendData(userName:String){
        
        self.db.collection("contents").document(userName).collection("collection").document().setData(
            
            ["userID":self.userID as Any,"userName":self.userName as Any,"videoID":self.videoID as Any,"title":self.title as Any,
             "publishTime":self.publishTime as Any,
             "channelTitle":self.channelTitle as Any,"postDate":Date().timeIntervalSince1970])
        
        self.db.collection("Users").addDocument(data: ["userName":self.userName])
        
    }
    
    
    func sendProfile(userName:String,imageData:Data,profireTextView:String){
        
        let imageRef = Storage.storage().reference().child("ProfileImageFolder").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpg")
        
        imageRef.putData(imageData, metadata: nil) { (metadate, error) in
            
            if error != nil{
                print(error.debugDescription)
                return
            }
            
            imageRef.downloadURL { (url, error) in
                
                if error != nil{
                    print(error.debugDescription)
                    return
                
            }
                self.db.collection("profile").document(userName).setData(
                
                    ["userName":userName as Any,"imageURLString":url?.absoluteString as Any,"profileTextView":profireTextView as Any]
                    
                )
                
                self.doneSendProfileDelegate?.doneSendProfileDelegate(sendCheck: 1)
            
        }
        
            
        
        
    }
    
    }

}
