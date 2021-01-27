//
//  ViewController.swift
//  YoutubeApp1
//
//  Created by 大内晴貴 on 2021/01/25.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var textfield: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        button.layer.cornerRadius = 10
        
    }

    @IBAction func createNewuser(_ sender: Any) {
        
        createUser()
        
    }
        
    func createUser(){
            
            Auth.auth().signInAnonymously { (result, error) in
                let user = result?.user
                print(user.debugDescription)
                
                //アプリ内にテキストフィールドのテキストをほぞん
                UserDefaults.standard.set(self.textfield.text,forKey: "userName")
                
                
                let profileVC = self.storyboard?.instantiateViewController(identifier: "profileVC") as!
                ProfileViewController
                profileVC.userName = self.textfield.text!
                
                self.navigationController?.pushViewController(profileVC, animated: true)
                
                
                
                
                //画面遷移
             //   let profile = self
                
            }
            
        
    }
    
}

