//
//  ViewController.swift
//  YoutubeApp1
//
//  Created by 大内晴貴 on 2021/01/25.
//

import UIKit
import FirebaseAuth
import Pastel

class ViewController: UIViewController {
    @IBOutlet weak var textfield: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let pastelView = PastelView(frame: view.bounds)

           // Custom Direction
           pastelView.startPastelPoint = .bottomLeft
           pastelView.endPastelPoint = .topRight

           // Custom Duration
           pastelView.animationDuration = 3.0

           // Custom Color
           pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                                 UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
                                 UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
                                 UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
                                 UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
                                 UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                                 UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])

           pastelView.startAnimation()
           view.insertSubview(pastelView, at: 0)
        
        
           
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
                UserDefaults.standard.setValue(self.textfield.text, forKey: "userName")
                //画面遷移
                
                
                let profileVC = self.storyboard!.instantiateViewController(identifier: "profileVC") as!
                ProfileViewController
                profileVC.userName = self.textfield.text!
                
                self.navigationController?.pushViewController(profileVC, animated: true)
                
                
                
            }
            
        
    }
    
}

