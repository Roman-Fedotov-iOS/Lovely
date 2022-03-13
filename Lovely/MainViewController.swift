//
//  MainViewController.swift
//  Lovely
//
//  Created by Roman Fedotov on 13.03.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var shakeImg: UIImageView!
    @IBOutlet weak var smileLbl: UILabel!
    @IBOutlet weak var shakeLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
        
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }

    // Enable detection of shake motion
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            UIView.transition(with: self.shakeImg,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.shakeImg.image = UIImage(named: "SuccessHeart")
            }, completion: nil)
            UIView.transition(with: self.smileLbl,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.smileLbl.text = "You are simply the best"
            }, completion: nil)
            UIView.transition(with: self.shakeLbl,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.shakeLbl.text = ""
            }, completion: nil)
        }
    }

}
