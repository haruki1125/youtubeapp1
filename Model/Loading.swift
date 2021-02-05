//
//  Loading.swift
//  YoutubeApp1
//
//  Created by 大内晴貴 on 2021/01/29.
//

import Foundation
import Lottie

class Loading {
    let animationView = AnimationView()
    
    func startAnimation(view:UIView){
        let animation = Animation.named("loading")
        animationView.frame = CGRect(x: 0,y: 5,width: view.frame.size.width,height: view.frame.size.height/1.5)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
    }
    
    func stopAnimation(){
        animationView.removeFromSuperview()
    }
}
