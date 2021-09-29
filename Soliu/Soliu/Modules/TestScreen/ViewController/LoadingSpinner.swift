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
        
        moveToResultScreen()
        
    }
    
    private func moveToResultScreen() {
        // wait for 2 sec to get to the result screen
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: "toResultScreen", sender: nil)
        }
    }
}
