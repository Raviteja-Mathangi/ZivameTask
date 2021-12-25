//
//  Extension+ViewController.swift
//  ZivameTask
//
//  Created by Raviteja Mathangi on 25/12/21.
//

import Foundation
import AVFoundation
import AudioToolbox
import UIKit
import Lottie
extension UIViewController{
    func playSystemSound(){
        AudioServicesPlaySystemSound((SystemSoundID("1312")!))
    }
    func lottieInView(isDisplay : Bool, baseView: UIView, withAnimation animateName:String){
        let animationView = AnimationView()
        animationView.animation = Animation.named(animateName)
        animationView.frame.size = baseView.frame.size
        animationView.contentMode = .center
        if isDisplay{
            baseView.addSubview(animationView)
            animationView.loopMode = .loop
            animationView.play()
        }else{
            animationView.removeFromSuperview()
        }
    }
}
