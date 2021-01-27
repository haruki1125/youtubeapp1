//
//  ListViewController.swift
//  YoutubeApp1
//
//  Created by 大内晴貴 on 2021/01/27.
//

import UIKit
import SDWebImage
import youtube_ios_player_helper

class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,DoneLoadDataProtocol,DoneLoadUserNameProtocol {
    
    
    
    
    
    
    var tag = Int()
    var userName = String()
    var dataSetsArray = [DataSets]()
    var userNameArray = [String]()
    var searchAndLoad = SeachAndLoadModel()
    
    
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(tag)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "VideoCell", bundle:  nil), forCellReuseIdentifier: "VideoCell")
        tableView.register(UINib(nibName: "UserNameCell", bundle:  nil), forCellReuseIdentifier: "Cell")
        
        
        searchAndLoad.doneLoadDataProtocol = self
        searchAndLoad.doneLoadUserNameProtocol = self
        if tag == 1{
            
            searchAndLoad.loadMyListData(userName: userName)
            
        }else if tag == 2{
            
            searchAndLoad.loadDtherListData()
            
        }
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        if tag == 1{
            self.navigationItem.title = "自分のリスト"
        }else if tag == 2{
            self.navigationItem.title = "みんなのリスト"
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tag == 1{
            
            return dataSetsArray.count
            
        }else{
            
            return userNameArray.count
            
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tag == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
            cell.titleLabel.text = dataSetsArray[indexPath.row].title
            cell.thumnaillimageView.sd_setImage(with: URL(string: dataSetsArray[indexPath.row].url!), completed: nil)
            cell.channelTitleLabel.text = dataSetsArray[indexPath.row].channelTitle
            cell.dateLabel.text = dataSetsArray[indexPath.row].publishTime
            return cell
            
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserNameCell
            
            cell.userNameLabel.text = userNameArray[indexPath.row]
            return cell
            
        }
    }
    
    
    func doneLoadData(array: [DataSets]) {
        dataSetsArray = array
        tableView.reloadData()
    }
    
    func doneLoadUserName(array: [String]) {
        userNameArray = []
        //重複消す作業
        let orderedSet = NSOrderedSet(array: array)
        print (orderedSet.description)
        userNameArray = orderedSet.array as! [String]
        
        tableView.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
