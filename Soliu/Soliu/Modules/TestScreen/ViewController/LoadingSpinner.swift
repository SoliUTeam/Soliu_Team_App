//
//  LoadingSpinner.swift
//  Soliu
//
//  Created by JungpyoHong on 9/16/21.
//

import Lottie
import UIKit

protocol LoadingSpinnerProtocol {
    
}

class LoadingSpinner: UIViewController {
    
    @IBOutlet weak var animationView: AnimationView!
    override func viewDidLoad() {

      super.viewDidLoad()
      
      // 1. Set animation content mode
      
      animationView.contentMode = .scaleAspectFit
      
      // 2. Set animation loop mode
      
      animationView.loopMode = .loop
      
      // 3. Adjust animation speed
      
      animationView.animationSpeed = 1
      
      // 4. Play animation
      animationView.play()
    }
}
