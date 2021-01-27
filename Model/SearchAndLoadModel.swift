//
//  SearchAndLoadModel.swift
//  YoutubeApp1
//
//  Created by 大内晴貴 on 2021/01/26.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftyJSON
import Alamofire
import FirebaseAuth

protocol DoneCatchDataProtocol {
    func doneCatchData(array:[DataSets])
}

protocol DoneLoadDataProtocol {
    
    func doneLoadData(array:[DataSets])
    
}

protocol DoneLoadUserNameProtocol {
    
    func doneLoadUserName(array:[String])
    
}


class SeachAndLoadModel {
    var urlString = String()
    var resultParPage = Int()
    var dataSetsArray:[DataSets] = []
    var doneCatchDataProtocol:DoneCatchDataProtocol?
    var doneLoadDataProtocol:DoneLoadDataProtocol?
    var doneLoadUserNameProtocol:DoneLoadUserNameProtocol?
    var db = Firestore.firestore()
    var userNameArray = [String]()
    
    
    init(urlString:String) {
        self.urlString = urlString
        
    }
    
    init() {
        
    }
    
    func search(){
        let encordeUrlString =
            self.urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        AF.request(encordeUrlString as! URLConvertible, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            
        
            
            print(response)
            
            switch response.result{
            
            
            case .success:
                do{
                    let json:JSON = try JSON(data: response.data!)
                    print(json.debugDescription)
                    
                    let totalHitCount = json["pageInfo"]["resultsParPage"].int
                    
                    if totalHitCount! < 50{
                        self.resultParPage = totalHitCount!
                        
                    }else{
                        self.resultParPage = totalHitCount!
                    }
                    
                    print(self.resultParPage)
                    for i in 0...self.resultParPage - 1{
                        
                        if let title =  json["items"][i]["snippet"]["title"].string,let description = json["items"][i]["snippet"]["description"].string,let url = json["items"][i]["snippet"]["thumbnails"]["default"]["url"].string,let channelTitle = json["items"][i]["snippet"]["channelTitle"].string,let publishTime = json["items"][i]["snippet"]["publishTime"].string,let channelId = json["items"][i]["snippet"]["channelId"].string{
                            
                            if json["items"][i]["id"]["channelId"].string == channelId{
                            
                            }else{
                                let dataSets = DataSets(videoID: json["items"][i]["id"]["videoId"].string, title: title, description: description, url: url, channelTitle: channelTitle, publishTime: publishTime)
                                
                                if title.contains("Error 404") == true || description.contains("Error 404") == true || url.contains("Error 404") == true || channelTitle.contains("Error 404") == true || publishTime.contains("Error 404") == true{
                                    
                                }else{
                                    
                                    
                                    self.dataSetsArray.append(dataSets)
                                    
                                    
                                }
                            }
                        }else{
                            print("空です。何か不足したいます")
                        }
                           
                        
                    }
                    
                    self.doneCatchDataProtocol?.doneCatchData(array: self.dataSetsArray )
                    
                }catch{
                    
                }
            
            
            
            case .failure(_): break
                
            }
        }
        
        
    }
    
    func loadMyListData(userName:String){
        db.collection("contents").document(userName).collection("collection").order(by: "postDate").addSnapshotListener{(snapShot, error) in
            
            self.dataSetsArray = []
            
            if errno != nil {
                
            print(error.debugDescription)
            return
    }
    
            if let snapShotDoc = snapShot?.documents{
                
                for doc in snapShotDoc{
                    
                    let data = doc.data()
                    print(data.debugDescription)
                    if let videoID = data["videoID"] as? String,let urlString = data["urlString"] as?  String,let title = data["title"] as? String,let description = data["description"] as? String,let channelTitle = data["channelTitle"] as? String,let publishTime = data["publishTime"] as? String{
                        
                        let dataSets = DataSets(videoID: videoID, title: title, description: description, url: urlString, channelTitle: channelTitle, publishTime: publishTime)
                        self.dataSetsArray.append(dataSets)
                        
                    }
                }
                
                self.doneLoadDataProtocol?.doneLoadData(array: self.dataSetsArray)
                
                
            }
           
        }
    }
    
    func loadDtherListData(){
        db.collection("Users").addSnapshotListener { (snapShot, error) in
            if let sanapShotDoc = snapShot?.documents{
                for doc in sanapShotDoc{
                    let data = doc.data()
                    if let userName = data["userName"] as? String{
                        self.userNameArray.append(userName)
                    }
                }
                
                self.doneLoadUserNameProtocol?.doneLoadUserName(array: self.userNameArray)
                
            }
        }
    }
    
}
