//
//  CheckoutVC.swift
//  ZivameTask
//
//  Created by Raviteja Mathangi on 25/12/21.
//

import UIKit
import AVFoundation
import AVKit
class CheckoutVC: UIViewController {
    @IBOutlet weak var lottieView: UIView!
    private var player: AVPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(restartVideo),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: self.player?.currentItem)
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
            self.player?.pause()
            let orderPlacedVC =  self.storyboard?.instantiateViewController(withIdentifier: "OrderPlacedVC") as! OrderPlacedVC
            self.navigationController?.pushViewController(orderPlacedVC, animated: true)
        }
    }
    //MARK:- Notification selector method
    @objc func restartVideo() {
        player?.pause()
        player?.currentItem?.seek(to: CMTime.zero, completionHandler: { _ in
            self.player?.play()
        })
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "loader", ofType: "mp4")!))
        let layer = AVPlayerLayer(player: player)
        layer.frame = lottieView.bounds
        lottieView.layer.addSublayer(layer)
        player?.play()
    }
}
