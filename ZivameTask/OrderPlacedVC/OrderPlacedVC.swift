//
//  OrderPlacedVC.swift
//  ZivameTask
//
//  Created by Raviteja Mathangi on 25/12/21.
//

import UIKit
import AVFoundation
import AVKit

class OrderPlacedVC: UIViewController {
    @IBOutlet weak var successView: UIView!
    private var player: AVPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //MARK:- Success lottie animation video play
        player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "success", ofType: "mp4")!))
        let layer = AVPlayerLayer(player: player)
        layer.frame = successView.bounds
        successView.layer.addSublayer(layer)
        player?.play()
    }

}
